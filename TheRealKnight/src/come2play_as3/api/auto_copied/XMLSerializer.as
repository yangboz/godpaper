package come2play_as3.api.auto_copied
{
public final class XMLSerializer
{
	public static function test():void {			
		var test:Object = [1,2,"c",true,null, -4,"<&&boo>",{a:null,x: new SerializableClass(), b:["","b"]}];
		var xml:XML = XMLSerializer.toXML(test);
		var test2:Object = SerializableClass.deserialize(XMLSerializer.xml2Object(xml));
		StaticFunctions.storeTrace("XMLSerializer xml=\n"+xml+" test2="+JSON.stringify(test2));
		StaticFunctions.assert(StaticFunctions.areEqual(test,test2),"XMLSerializer",[test,test2]);		
	}
	public static function xml2Object(xml:XML):Object {
		var name:String = AS3_vs_AS2.xml_getName(xml);
		if (name==RESERVED_NAMES.nullName) return null;
		if (name==RESERVED_NAMES.num || 
			name==RESERVED_NAMES.bool || 
			name==RESERVED_NAMES.str) {
			var simpleContent:String = AS3_vs_AS2.xml_getSimpleContent(xml);
			if (name==RESERVED_NAMES.num)
				return Number(simpleContent);
			if (name==RESERVED_NAMES.bool)
				return Boolean(simpleContent);
			return simpleContent;
		}
		var children:Array/*XML*/ = AS3_vs_AS2.xml_getChildren(xml);
		if (name==RESERVED_NAMES.arr) {
			var arr:Array = [];
			for each (var child2:XML in children) {
				arr.push( xml2Object(child2) );
			}
			return arr;					
		} else {
			var obj:Object = {};
			if (name!=RESERVED_NAMES.obj)
				obj[SerializableClass.CLASS_NAME_FIELD] = name;
				
			for each (var child:XML in children) {
				var singleGrandChild:Array = 
					AS3_vs_AS2.xml_getChildren(child);
				StaticFunctions.assert(singleGrandChild.length==1, "A field should have a single value! Illegal child=",[child]);
				obj[ AS3_vs_AS2.xml_getName(child) ] =
					xml2Object( singleGrandChild[0] );
			}
			return obj;
		}
	}
    public static function toXML(arg:Object):XML {
    	return AS3_vs_AS2.xml_create(toString(arg));	    		    	
    }	    
    public static function toString(arg:Object):String {
    	var res:Array = [];
    	p_toString("", res, arg);
    	return res.join("");	    	
    }
    public static function escapeXML(str:String):String {
    	// escaping &<>  to &amp;&lt;&gt;
		return 	StaticFunctions.replaceAll(
				StaticFunctions.replaceAll(
				StaticFunctions.replaceAll(str,"&","&amp;"),
				 							"<","&lt;"),
				 							">","&gt;");					 							
    }
    public static function isReserved(s:String):Boolean {
    	for each (var str:String in RESERVED_NAMES) {
    		if (s==str) return true;	    		
    	}
    	return false;
    }
    private static var RESERVED_NAMES:Object =
    	{ nullName: "null",
    	  num: "num",
    	  bool: "bool",
    	  str: "str",
    	  arr: "arr",
    	  obj: "obj" };
    private static function p_toString(indentStr:String, res:Array, arg:Object):void {
    	var i:int;
    	var elementType:String = 
    		arg==null ? RESERVED_NAMES.nullName :
    		AS3_vs_AS2.isNumber(arg) ? RESERVED_NAMES.num :
    		AS3_vs_AS2.isBoolean(arg) ? RESERVED_NAMES.bool :
    		AS3_vs_AS2.isString(arg) ? RESERVED_NAMES.str : 
    		null;
    	var childrenKeys:Array = null;
    	var isArr:Boolean = AS3_vs_AS2.isArray(arg);
    	if (elementType==null) {
    		// complex element
    		if (isArr) {
    			elementType = RESERVED_NAMES.arr;
    			childrenKeys = [];
    			for (i = 0; i < arg.length; ++i) {
    				childrenKeys.push(i);
    			}
    		} else {
    			var serObj:SerializableClass = 
    				AS3_vs_AS2.isSerializableClass(arg) ?
    					AS3_vs_AS2.asSerializableClass(arg) : null;
    			elementType = serObj==null ? 
    				RESERVED_NAMES.obj : serObj.__CLASS_NAME__;
    			childrenKeys = serObj!=null ? serObj.getFieldNames() : JSON.getSortedKeys(arg);
    			if (serObj!=null) childrenKeys.sort();	
    		}
    	}
    	StaticFunctions.assert(elementType!=null, "Internal error! missing elementType",[]);
    	
    	if (childrenKeys==null) {
    		var simpleContent:String = arg==null ? "" : escapeXML(arg.toString());
    		res.push(indentStr+
    			(simpleContent=="" ? "<"+elementType+"/>" :	    		
    			"<"+elementType+">" + simpleContent + "</"+elementType+">")+
    			"\n");
    	} else { 
    		res.push(indentStr+"<"+elementType+">\n");
    		for each (var childKey:String in childrenKeys) {
	    		var esc:String;
	    		if (!isArr) {
		    		esc = escapeXML(childKey);
			    	res.push(indentStr + "\t<"+esc+">\n");
			    }
		    	p_toString(indentStr+(isArr ? "\t" : "\t\t"),res, arg[childKey]);
		    	if (!isArr) 
		    		res.push(indentStr + "\t</"+esc+">\n");	    			
    		}
    		res.push(indentStr+"</"+elementType+">\n");
    	}	    		    	 	
    }

}
}