package peote.audio.openAL;

// ------------------------------------------------
// ------------------- OpenAL ---------------------
// ------------------------------------------------

import haxe.Timer;
import haxe.io.Bytes;
import haxe.io.Float32Array;

import lime.media.openal.ALDevice;
import lime.media.openal.ALContext;
import lime.media.openal.ALC;
import lime.media.openal.AL;
import lime.media.openal.ALSource;

import peote.audio.intern.TimeStartList;
import peote.audio.intern.TimeEndList;

@:allow(peote.audio.openAL)
class AudioOpenAL
{
	public static inline var AL_FORMAT_MONO_FLOAT32 = 0x10010;

	public static var device(default, null):ALDevice = null;

	public static var context(default, null):ALContext = null;		
	public static var sampleRate(default, null):Int = 44100;

	public static var srcPool = new Array<SourceOpenAL>();
	public static var alSrcPool = new Array<ALSource>();
	public static var alSrcPoolMax:Int = 32;  // maximum what can play parallele
	public static var alSrcPoolIndex:Int = 0;

	public static var timeStartList = new TimeStartList();
	public static var timeEndList = new TimeEndList();
	public static var time:Float = 0.0;

	
	public static inline function init(defaultSampleRate:Int = 0)
	{
		if (context != null) throw("OpenAL already initialized");
		
		AL.getError(); // clear errorcode
		device = ALC.openDevice();
		context = ALC.createContext(device);
		sampleRate = (defaultSampleRate > 0) ? defaultSampleRate : ALC.getIntegerv(device, ALC.FREQUENCY, 1)[0];
				
		ALC.makeContextCurrent(context);
		ALC.processContext(context);

		if (AL.getError() != AL.NO_ERROR) trace("AL ERROR: init");
		
		// fill the pool by empty AL-Sources
		for (i in 0...alSrcPoolMax) {
			AL.getError();
			alSrcPool.push(AL.createSource());
			if (AL.getError() != AL.NO_ERROR) trace("AL ERROR: source create");				
		}
	}

	
	// ----------- POOLING ------------------

	public static inline function getALSourceFromPool(source:SourceOpenAL):ALSource
	{
		if (alSrcPoolIndex == alSrcPoolMax) // Pool is full
		{
			var freeSrc = alSrcPool.shift();
			alSrcPool.push(freeSrc);

			AL.sourceStop(freeSrc);
			AL.sourcei(freeSrc, AL.BUFFER, null); // unassign buffer

			// srcPool.shift();
			// prevent freeing the source if it is already removed from the Pool
			// TODO: check that this works correctly if pool is full
			timeEndList.remove( srcPool.shift() );
			srcPool.push(source);
			
			return freeSrc;
		}
		else {
			srcPool.push(source);
			return alSrcPool[alSrcPoolIndex++];
		}
	}

	public static inline function freeALSourceFromPool(source:SourceOpenAL)
	{
		AL.sourceStop(source.source);
		AL.sourcei(source.source, AL.BUFFER, null); // unassign buffer

		alSrcPool.remove(source.source);
		alSrcPool.push(source.source);
		alSrcPoolIndex--;

		srcPool.remove(source);
	}


	// --------- UPDATE -----------
	
	static var _audioSource:AudioSource;
	public static inline function update(?currentTime:Float)
	{
		time = (currentTime != null) ? currentTime : Timer.stamp();
		// trace("update",time);
		
		// check what have to start playing next:
		while (timeStartList.length != 0)
		{
			_audioSource = timeStartList[0];
			if (_audioSource.timeStart > time) break;			
			_audioSource.playALSource();
			timeStartList.shift();
		}

		// check what have to stop playing next:
		while (timeEndList.length != 0)
		{	
			_audioSource = timeEndList[0];
			if (_audioSource.timeEnd > time) break;
			_audioSource.stopALSource();
			timeEndList.shift();
		}
	}

	static inline function addToTimeStartList(audioSource:SourceOpenAL) {
		timeStartList.insertSort(audioSource);
		// var t="timeStartList: ["; for (s in timeStartList) t+=s.timeStart+","; t+="]";trace(t);
	}

	static inline function addToTimeEndList(audioSource:SourceOpenAL) {
		timeEndList.insertSort(audioSource);
		// var t="timeEndList: ["; for (s in timeEndList) t+=s.timeEnd+","; t+="]";trace(t);
	}

	// TODO:
	// delete and free all sources from the pool
	// ...AL.deleteSource(source);

	
	/*
	// creates buffer and source on the fly for playing

	// did not play parallele on hl-target if the source var is local inside the play() function !!!
	static var source:ALSource;	
	public static function play(data:Float32Array)
	{
		var buffer = AL.createBuffer();
		
		AL.bufferData(buffer, AL_FORMAT_MONO_FLOAT32,
			lime.utils.Float32Array.fromBytes(data.view.buffer),
			data.view.buffer.length, sampleRate);
		
		
		source = AL.createSource();
		
		AL.sourcef  (source, AL.PITCH, 1.0);
		AL.sourcef  (source, AL.GAIN, 1.0);
		AL.source3f (source, AL.POSITION, 0.0, 0.0, 0.0); // for first value: -1.0 -> left, 1.0 -> right
		AL.source3f (source, AL.VELOCITY, 0.0, 0.0, 0.0);

		// AL.sourcei(source, AL.SOURCE_TYPE, AL.STATIC);

		AL.sourcei(source, AL.BUFFER, buffer);

		AL.sourcePlay(source);
		// haxe.Timer.delay(()-> AL.sourcePlay(source), 100);
	}
	*/
}
