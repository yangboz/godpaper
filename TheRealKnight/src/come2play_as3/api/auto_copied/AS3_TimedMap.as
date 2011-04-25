package come2play_as3.api.auto_copied
{
import flash.utils.Dictionary;
	
public final class AS3_TimedMap 
	extends SerializableClass { // just for toString()
	
	public var maxMillisStayInMap:int;
	public var dic:Dictionary = new Dictionary(); // mapping key -> DebugInfo
	
	public function AS3_TimedMap(maxSecondsStayInMap:int=0) {
		this.maxMillisStayInMap = 1000*maxSecondsStayInMap;
		ErrorHandler.myInterval("AS3_TimedMap with maxMillisStayInMap="+maxMillisStayInMap, ticked, maxMillisStayInMap);			
	}
	private function ticked():void {
		for each (var debug:DebugInfo in dic) {			
			StaticFunctions.assert( !debug.time.havePassed(maxMillisStayInMap), "AS3_TimedMap: an entry stayed more than ",[maxMillisStayInMap, " entry=",debug, this]);
		}
	}
	public function add(key:Object, val:Object):void {
		StaticFunctions.assert( dic[key]==null, "AS3_TimedMap: key already exists! key=",[key,this]);
		var debug:DebugInfo = new DebugInfo();		
		debug.time = new TimeMeasure();
		debug.time.setTime();
		debug.val = val;
		dic[key] = debug;
	}
	// returns the val
	public function remove(key:Object):Object {
		var debug:DebugInfo = dic[key];
		StaticFunctions.assert(debug!=null, "AS3_TimedMap: missing key=",[key, this]);		
		delete dic[key];
		return debug.val;
	}
	public function contains(key:Object):Boolean {
		return dic[key]!=null;
	}
	public function getVal(key:Object):Object {
		return (dic[key] as DebugInfo).val;
	}
	public function getKeys():Array {
		var res:Array = [];
		for (var key:Object in dic)
			res.push(key);
		return res;
	}
	public function clear():void {
		dic = new Dictionary();
	}
	public function size():int {
		return AS3_vs_AS2.dictionarySize(dic);
	}
}
}

import come2play_as3.api.auto_copied.SerializableClass;
import come2play_as3.api.auto_copied.TimeMeasure;	
class DebugInfo extends SerializableClass {
	public var time:TimeMeasure;
	public var val:Object;
}