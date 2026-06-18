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


	public function update() {

	};

	// MORE HERE to wrap around both
	public function play(?duration:Float, repeat:Int = 0, ?onEndOfPlay:AudioSource->Void) {
		// TODO: Timescheduler
		// insert-sort source-IDs into a array for what is still playing and at what time it had to stop
		this.play();
	}

	public function playDelay(delay:Float, ?duration:Float, repeat:Int = 0, ?onEndOfPlay:AudioSource->Void) {
		// TODO: Timescheduler

		// ...call playFromTo(...)
	}
	public function playFromTo(startTime:Float, endTime:Float, repeat:Int = 0, ?onEndOfPlay:AudioSource->Void) {
		// insert-sort source-IDs into a array for what will start playing into future (and at what time)
		// insert-sort source-IDs into a array for what is still playing and at what time it had to stop
	}

	public function stop() {
	}

	public function stopAt(endTime) {
	}
}

