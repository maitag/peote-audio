package peote.audio;

#if html5
import peote.audio.web.AudioWeb as AudioBackend;
import peote.audio.web.BufferWeb as BufferBackend;
import peote.audio.web.SourceWeb as SourceBackend;
#else
import peote.audio.openAL.AudioOpenAL as AudioBackend;
import peote.audio.openAL.BufferOpenAL as BufferBackend;
import peote.audio.openAL.SourceOpenAL as SourceBackend;
#end

// ------------------------------------------------
// ----------- PeoteAudio - Wrapper ---------------
// ------------------------------------------------

@:forward
@:forwardStatics
abstract PeoteAudio(AudioBackend) from AudioBackend to AudioBackend
{	
	public static inline function init(?defaultSampleRate:Null<Int>) 
	{
		AudioBackend.init(defaultSampleRate);
	}
	
	// MORE HERE to wrap around both
}


@:forward
@:forwardStatics
abstract AudioBuffer(BufferBackend) from BufferBackend to BufferBackend
{
	public inline function new(duration:Float) 
	{
		this = new BufferBackend(duration);
	}

	// MORE HERE to wrap around both	
}

@:forward
@:forwardStatics
abstract AudioSource(SourceBackend) from SourceBackend to SourceBackend
{
	public inline function new(audioBuffer:AudioBuffer) 
	{
		this = new SourceBackend(audioBuffer);
	}

	// MORE HERE to wrap around both	
}

