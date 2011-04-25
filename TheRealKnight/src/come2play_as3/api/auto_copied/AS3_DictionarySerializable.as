package come2play_as3.api.auto_copied
{
	import flash.utils.Dictionary;
	
	public class AS3_DictionarySerializable extends AS3_NativeSerializable
	{
		public var keyValArr:Array = [];
		public function AS3_DictionarySerializable(dic:Dictionary=null) {
			super("Dictionary");
			if (dic!=null) {
				for (var k:Object in dic) 
		 			keyValArr.push([k, dic[k]]);
		 	}
		}	
		override public function fromNative(obj:Object):AS3_NativeSerializable {
			return obj is Dictionary ? new AS3_DictionarySerializable(obj as Dictionary) : null;
		}
		override public function postDeserialize():Object {
			var res:Dictionary = new Dictionary();
			for each (var keyVal:Array in keyValArr)
				res[ keyVal[0] ] = keyVal[1];
			return res;
		}	
	}
}