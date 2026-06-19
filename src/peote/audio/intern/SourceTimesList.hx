package peote.audio.intern;

@:generic
@:structInit
class SourceTime<T> {
	public var source:T;
	public var time:Float;
	public function new(source:T, time:Float) {
		this.source = source;
		this.time = time;
	}
}

@:generic
@:forward @:forward.new
abstract SourceTimesList<T>(Array<SourceTime<T>>) from Array<SourceTime<T>> to Array<SourceTime<T>> {
	
	// insert a value at index where it keeps the list sorted, returns these index
	public function insertSort(value:SourceTime<T>):Int {
		
		// ------ if list is empty --------- 
		if (this.length == 0) {
			this[0] = value;
			return 0;
		}
    
		// ------ only ONE element into list ------
		if (this.length == 1) {
			if (this[0].time < value.time) {
				this.insert(0, value);
				return (0);
			}
			else {
				this.push(value);
				return (1);
			}
		}
	
		// ------ more then one element into list --> travel recursively up and down from the "middle"			
		var from:Int = 0;
		var to:Int = this.length;
		var i:Int = from + ((to-from) >> 1);

		while (from+1 < to) { 
			if (this[i].time < value.time) {
				if (this[i-1].time >= value.time) {
					this.insert(i, value);
					return(i);
				}
				to = i;
			}
			else from = i;

			i = from + ((to-from) >> 1);
		}
		
		if (from == 0) this.unshift(value) else this.push(value);

		return( (from == 0) ? 0 : this.length-1 );
	}

}