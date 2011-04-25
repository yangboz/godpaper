package come2play_as3.api.auto_copied
{
	public class AS3_ErrorSerializable extends AS3_NativeSerializable
	{
		public var stackTraces:String;
		public var message:String;
		public var errorId:int;
		public function AS3_ErrorSerializable(err:Error=null) {
			super("Error");
			message = err==null ? null : err.message;
			stackTraces = err==null ? null : err.getStackTrace();
			errorId = err==null ? 0 : err.errorID;
		}	
		override public function fromNative(obj:Object):AS3_NativeSerializable {
			return obj is Error ? new AS3_ErrorSerializable(obj as Error) : null;
		}
		override public function postDeserialize():Object {
			return new Error(message, errorId);
		}	
	}
}