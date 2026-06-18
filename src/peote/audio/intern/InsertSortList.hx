package peote.audio.intern;

@:forward @:forward.new
abstract InsertSortList<T>(Array<T>) from Array<T> to Array<T> {
	
	// insert a value at index where it keeps the list sorted, returns these index
	public function insertSort(value:T):Int {
		

		// ------ if list is empty --------- 

		if (this.length == 0)
		{
			this[0] = value; //trace("init");
			return 0;
		}
    
		// ------ only ONE element into list ------

		if (this.length == 1)
		{
			if (Reflect.compare(this[0], value) > 0)
			{
				this.insert(0, value);
				return (0);
			}
			else
			{
				this.push(value);
				return (1);
			}
		}
	
		// ------ more then one element into list --> travel recursively up and down from the "middle"
			
		var from:Int = 0;
		var to:Int = this.length;
		var i:Int = from + ((to-from) >> 1);

		while (from+1 < to)
		{ 
			if (Reflect.compare(this[i], value) > 0) 
			{
				if (Reflect.compare(this[i-1], value) <= 0) {
					this.insert(i, value); // trace("insert at index:",i);
					return(i);
				}
				to = i;
			}
			else from = i;

			i = from + ((to-from) >> 1);
		}
		
		if (from == 0) this.unshift(value) else this.push(value);

		// trace("insert at head or tail index:", (from == 0) ? 0 : this.length-1 );
		return( (from == 0) ? 0 : this.length-1 );
	}

}