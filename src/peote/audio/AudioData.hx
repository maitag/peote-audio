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






/*import lime.media.vorbis.VorbisFile;
import lime.utils.Bytes;

class Decoder {
    public static function decodeOggManually(filePath:String) {
        // Open the OGG file container using Lime's VorbisFile binding
        var vorbisFile = VorbisFile.fromFile(filePath);
        
        if (vorbisFile != null) {
            var totalSamples = vorbisFile.pcmTotal();
            trace("Total PCM Samples: " + totalSamples);
            
            // Allocate a buffer for a chunk of raw data
            var bufferSize = 4096;
            var bytes = Bytes.alloc(bufferSize);
            
            // Read decoded PCM chunks
            // read(buffer, byteOffset, length, bigEndian, wordSize, signed)
            var bytesRead = vorbisFile.read(bytes, 0, bufferSize, false, 2, true);
            
            trace("Decoded chunk size in bytes: " + bytesRead);
            vorbisFile.close();
        }
    }
}
	*/