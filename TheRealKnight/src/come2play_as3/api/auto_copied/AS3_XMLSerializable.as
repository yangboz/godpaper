package come2play_as3.api.auto_copied
{
	public class AS3_XMLSerializable extends AS3_NativeSerializable
	{
		public var xmlStr:String;
		public function AS3_XMLSerializable(xml:XML=null) {
			super("XML");
			xmlStr = xml==null ? null : xml.toXMLString();
		}	
		override public function fromNative(obj:Object):AS3_NativeSerializable {
			return obj is XML ? new AS3_XMLSerializable(obj as XML) : null;
		}
		override public function postDeserialize():Object {
			return AS3_vs_AS2.xml_create(xmlStr);
		}	
		
	}
}