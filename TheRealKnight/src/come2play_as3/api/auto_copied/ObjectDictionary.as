package come2play_as3.api.auto_copied
{
import come2play_as3.api.auto_generated.ServerEntry;
	
public final class ObjectDictionary extends SerializableClass
{
	// maps a hash of an object to an array of entries
	// each entry is: [key,value]
	//all the variables of this class are public because it extends SerializableClass
	public var hashMap:Object;
	public var pSize:int;
	// the order of inserted keys and values is important in the API for server entries
	public var allKeys:Array;
	public var allValues:Array;

	public function ObjectDictionary()
	{
		hashMap = new Object();
		pSize = 0;	
		allKeys = [];
		allValues = [];
	}
	
	private function getEntry(key:Object):Array {
		var hash:int = hashObject(key);
		if (hashMap[hash]==null) return null;
		var entries:Array = hashMap[hash];
		for each (var entry:Array in entries) {
			var entryKey:Object = entry[0];
			if (areEqual(entryKey,key)) 
				return entry;
			// not equal, let's check if someone changed the keys
			
			/*if (hashObject(entryKey)!=hash)
				throw new Error("You have mutated a key that was previously inserted to this ObjectDictionary! All keys must be immutable! mutated-key="+JSON.stringify(entryKey)+" looking-for-key="+JSON.stringify(key));
		*/
		}
		return null;		
	}
	public function size():int {
		return pSize;
	}
	public function getValues():Array {		
		return allValues;		
	}
	public function getKeys():Array {		
		return allKeys;		
	}
	public function hasKey(key:Object):Boolean {
		return getEntry(key)!=null;
	}
	public function getValue(key:Object):Object {
		var entry:Array = getEntry(key);
		return entry==null ? null : entry[1];
	}
	public function remove(key:Object):Object {
		var hash:int = hashObject(key);
		if (hashMap[hash]==null) return null;
		var entries:Array = hashMap[hash];
		for (var i:int=0; i<entries.length; i++) {
			var entry:Array = entries[i];
			var oldKey:Object = entry[0];
			if (areEqual(oldKey,key)) {
				entries.splice(i,1);
				if (entries.length==0) {
					delete hashMap[hash];
				}				
				pSize--;
				
				// Note that I check for oldKey (not key), so I can use indexOf that checks using object identity (not areEqual)
				var indexInAll:int = AS3_vs_AS2.IndexOf(allKeys,oldKey);
				if (indexInAll==-1) throw new Error("Internal error in ObjectDictionary");
				allKeys.splice(indexInAll,1);
				allValues.splice(indexInAll,1);
				
				return entry[1];					
			}				
		}
		return null;
	}
	public function put(key:Object, value:Object):void {
		remove(key);
		
		var hash:int = hashObject(key);				
		if (hashMap[hash]==null) hashMap[hash] = [];
		var entries:Object = hashMap[hash];
		entries.push( [key, value] );
		pSize++;
		
		allKeys.push(key);
		allValues.push(value);
	}
	public function addEntry(entry:ServerEntry):void {
		if (entry.visibleToUserIds==null && entry.value==null) { // deletions are always public (visible to everyone)
			remove(entry.key);
		} else {
			put(entry.key, entry);			
		}
	}
	
	// Some primes: Do I want to use them to hash an array?
	// 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139
	public static function hashObject(o:Object):int {
		if (o==null) return 541;		
        if (AS3_vs_AS2.isBoolean(o))	
			return o ? 523 : 521;		
        if (AS3_vs_AS2.isNumber(o))
        	return AS3_vs_AS2.convertToInt(o);  
        var res:int;
	    if (AS3_vs_AS2.isString(o)) {
	    	var str:String = o.toString();
	    	var len:int = str.length;
	    	res = 509;
	    	for (var i:int = 0; i < len; i++) {
	       		res <<= 1;
                res ^= str.charCodeAt(i);
            }
            return res;
	    } 
        if (AS3_vs_AS2.isArray(o)) {
        	res = 503;        	
	       	for (i = 0; i < o.length; i++) {
	       		res <<= 1;
	       		res ^= hashObject(o[i]);
	       	}
	       	return res;        	
        }
        
        res = 499;        	
        for (var z:String in o) {
        	res ^= hashObject(z)^hashObject(o[z]);
	    }
       	return res; 
	}
	public static function areEqual(o1:Object, o2:Object):Boolean {
		return StaticFunctions.areEqual(o1,o2);
	}
}
}