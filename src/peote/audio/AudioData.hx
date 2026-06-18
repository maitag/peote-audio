package peote.audio;


// TODO:

class AudioDataImpl {

	var sampleRate:Int = 44100;

	public function new() {

	}
}

abstract AudioData(AudioDataImpl) {

	public function new(audioData:AudioDataImpl) {
		this = new AudioDataImpl();
	}

}