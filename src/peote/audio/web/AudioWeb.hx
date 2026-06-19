package peote.audio.web;

// ------------------------------------------------
// ------------------- WebAudio -------------------
// ------------------------------------------------

import haxe.io.Float32Array;
import js.html.audio.AudioContext;

import peote.audio.intern.TimeStartList;
import peote.audio.intern.TimeEndList;

class AudioWeb
{
	public static var context(default, null):AudioContext = null;		
	public static var sampleRate(default, null):Int = 44100;


	public static var timeStarList = new TimeStartList();
	public static var timeEndList = new TimeEndList();
	
		
	public static inline function init(defaultSampleRate:Int = 0)
	{
		if (context != null) throw("WebAudio already initialized");

		if (defaultSampleRate > 0) {
			context = new AudioContext({sampleRate: defaultSampleRate});
			sampleRate = defaultSampleRate;
		}
		else {
			context = new AudioContext();
			sampleRate = Std.int(context.sampleRate);
		}
	}

	public static inline function update() {
		// handle timeStarList and timeEndList
	};

	/*
	// creates buffer and source on the fly for playing
	public static inline function play(data:Float32Array)
	{			
		var buffer = context.createBuffer(1, data.view.buffer.length, sampleRate);
		buffer.copyToChannel( cast data, 0, 0);
		
		var source = context.createBufferSource();
		source.buffer = buffer;
		source.connect(context.destination);
		source.start();
		
	}
	*/
}
