package peote.audio;

#if html5
import peote.audio.web.SourceWeb as SourceBackend;
#else
import peote.audio.openAL.SourceOpenAL as SourceBackend;
#end

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

