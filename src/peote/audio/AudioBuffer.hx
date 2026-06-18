package peote.audio;

#if html5
import peote.audio.web.BufferWeb as BufferBackend;
#else
import peote.audio.openAL.BufferOpenAL as BufferBackend;
#end

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
