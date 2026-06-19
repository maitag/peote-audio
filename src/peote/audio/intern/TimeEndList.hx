package peote.audio.intern;

@:forward @:forward.new @:arrayAccess
abstract TimeEndList(Array<AudioSource>) //from Array<AudioSource> to Array<AudioSource>
{	
	// insert a audioSource at index where it keeps the list sorted, returns these index
	public function insertSort(audioSource:AudioSource):Int {
		
		// ------ if list is empty --------- 
		if (this.length == 0) {
			this[0] = audioSource;
			return 0;
		}
    
		// ------ only ONE element into list ------
		if (this.length == 1) {
			if (audioSource.timeEnd < this[0].timeEnd) {
				this.insert(0, audioSource);
				return (0);
			}
			else {
				this.push(audioSource);
				return (1);
			}
		}
	
		// ------ more then one element into list --> travel recursively up and down from the "middle"			
		var from:Int = 0;
		var to:Int = this.length;
		var i:Int = from + ((to-from) >> 1);

		while (from+1 < to) { 
			if (audioSource.timeEnd < this[i].timeEnd) {
				if (audioSource.timeEnd >= this[i-1].timeEnd) {
					this.insert(i, audioSource);
					return(i);
				}
				to = i;
			}
			else from = i;

			i = from + ((to-from) >> 1);
		}
		
		if (from == 0) this.unshift(audioSource) else this.push(audioSource);

		return( (from == 0) ? 0 : this.length-1 );
	}
}