package peote.audio.web;

// ------------------------------------------------
// ------------------- OpenAL ---------------------
// ------------------------------------------------

import js.html.audio.AudioBufferSourceNode;


class SourceWeb
{
	public var source(default, null):AudioBufferSourceNode;

	
	public var timeStart:Float;
	public var timeEnd:Float;


	public function new(audioBuffer:BufferWeb)
	{
		source = AudioWeb.context.createBufferSource();
		source.buffer = audioBuffer.buffer;
	}

	public function play()
	{
		source.connect(AudioWeb.context.destination);
		source.start();
	}
}
