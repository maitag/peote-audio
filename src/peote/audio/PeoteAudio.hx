package peote.audio;

#if html5
import peote.audio.web.AudioWeb as AudioBackend;
#else
import peote.audio.openAL.AudioOpenAL as AudioBackend;
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

