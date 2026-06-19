package peote.audio.openAL;

// ------------------------------------------------
// ------------------- OpenAL ---------------------
// ------------------------------------------------

import lime.media.openal.*;

@:allow(peote.audio.openAL)
class SourceOpenAL
{
	/*
	#if hl
	// little hack to prevent hashlinks garbage collector from deleting the source al-pointer too early
	static var _sources = new haxe.ds.Vector<ALSource>(3);
	static var _sourcesIndex:Int = 0;

	public var source(default, set):ALSource;

	inline function set_source(s:ALSource):ALSource {
		_sources.set(_sourcesIndex++, s);
		if (_sourcesIndex >= _sources.length) _sourcesIndex = 0;
		return source = s;
	}
	#else
	*/
	public var source(default, null):ALSource;

	// #end

	public var buffer:BufferOpenAL;

	public var timeStart:Float;
	public var timeEnd:Float;


	public function new(audioBuffer:BufferOpenAL)
	{

		// TODO: only calculate duration etc.

		buffer = audioBuffer;

		/*
		// -> this here if it comes to "play" only:
		AL.getError();
		source = AL.createSource();
		if (AL.getError() != AL.NO_ERROR) trace("AL ERROR: source create");
		*/
	}

	function playALSource() {
		trace("get a new ALSource and play it");
		source = AudioOpenAL.getALSource(this);

		AL.getError();
		AL.sourcef  (source, AL.PITCH, 1.0);
		AL.sourcef  (source, AL.GAIN, 1.0);
		AL.source3f (source, AL.POSITION, 0.0, 0.0, 0.0); // for first value: -1.0 -> left, 1.0 -> right
		AL.source3f (source, AL.VELOCITY, 0.0, 0.0, 0.0);
		// AL.sourcei(source, AL.SOURCE_TYPE, AL.STATIC);
		// AL.sourcei(source, AL.SOURCE_TYPE, AL.STREAMING);
		if (AL.getError() != AL.NO_ERROR) trace("AL ERROR: source set properties");
		
		AL.getError();
		AL.sourcei(source, AL.BUFFER, buffer.buffer);
		if (AL.getError() != AL.NO_ERROR) trace("AL ERROR: source bind to buffer");

		// ---- PLAY ----
		AL.getError();
		AL.sourcePlay(source);	
		if (AL.getError() != AL.NO_ERROR) trace("AL ERROR: source play");
	}

	function stopALSource() {
		trace("stop and free the ALSource");


		AudioOpenAL.freeALSource(this);
	}
	

	public function play(?duration:Float, repeat:Int = 0, ?onEndOfPlay:SourceOpenAL->Void) {
		playALSource();
		timeStart = AudioOpenAL.time;
		timeEnd = timeStart + ((duration!=null) ? duration : buffer.duration);
		AudioOpenAL.addToTimeEndList(this);
	}

	public function playDelay(delay:Float, ?duration:Float, repeat:Int = 0, ?onEndOfPlay:SourceOpenAL->Void) {
		timeStart = AudioOpenAL.time + delay;
		timeEnd = timeStart + ((duration!=null) ? duration : buffer.duration);
		AudioOpenAL.addToTimeStartList(this);
		AudioOpenAL.addToTimeEndList(this);
	}
	public function playFromTo(startTime:Float, endTime:Float, repeat:Int = 0, ?onEndOfPlay:SourceOpenAL->Void) {
		if (endTime <= startTime || startTime < AudioOpenAL.time) throw ("wrong timing");
		timeStart = startTime;
		timeEnd = endTime;
		// play immediadly (or from that point at time ?)
		if (timeStart <= AudioOpenAL.time) { 
			playALSource();
		}
		else AudioOpenAL.addToTimeStartList(this);
		AudioOpenAL.addToTimeEndList(this);
	}

	public function stop() {}

	public function stopAt(endTime) {}	

	
}
