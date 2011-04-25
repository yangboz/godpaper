package come2play_as3.api.auto_copied
{
	import come2play_as3.api.auto_copied.SerializableClass;

	public class AS3_NativeSerializable extends SerializableClass
	{
		public function AS3_NativeSerializable(shortName:String=null) {
			super(shortName);
		}
		public function fromNative(obj:Object):AS3_NativeSerializable {
			throw new Error("Must override fromNative");
		}	
		override public function postDeserialize():Object {
			throw new Error("Must override postDeserialize");
		}
		
	}
}