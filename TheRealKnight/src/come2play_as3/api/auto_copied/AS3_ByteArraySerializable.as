package come2play_as3.api.auto_copied
{
	import flash.utils.ByteArray;
	
	public class AS3_ByteArraySerializable extends AS3_NativeSerializable
	{
		public var arr:Array/*int*/;
		public function AS3_ByteArraySerializable(byteArr:ByteArray=null) {
			super("ByteArray");
			arr = byteArr==null ? null : byteArr2Arr(byteArr);
		}	
		override public function fromNative(obj:Object):AS3_NativeSerializable {
			return obj is ByteArray ? new AS3_ByteArraySerializable(obj as ByteArray) : null;
		}
		public static function byteArr2Arr(byteArr:ByteArray):Array {
			var bytes:Array = [];
			for (var i:int=0; i<byteArr.length; i++)
				bytes.push(byteArr[i]);
			return bytes;
		}
		override public function postDeserialize():Object {
			var res:ByteArray = new ByteArray();
			for each (var i:int in arr)
				res.writeByte(i);
			res.position = 0; 
			return res;
		}	
		
	}
}