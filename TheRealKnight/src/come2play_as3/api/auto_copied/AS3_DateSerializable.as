package come2play_as3.api.auto_copied
{
	public class AS3_DateSerializable extends AS3_NativeSerializable
	{
		//public var utcDate:String; //Tue Feb 1 00:00:00 2005 UTC
		public var millis:Number; //the number of milliseconds since midnight January 1, 1970, universal time
		public function AS3_DateSerializable(date:Date=null) {
			super("Date");
			//utcDate = date==null ? null : date.toUTCString();
			millis = date==null ? null : date.valueOf();
		}	
		override public function fromNative(obj:Object):AS3_NativeSerializable {
			return obj is Date ? new AS3_DateSerializable(obj as Date) : null;
		}
		override public function postDeserialize():Object {
			return new Date(millis); //millis<=0 ? utcDate : millis
		}	
	}
}