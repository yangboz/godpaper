package com.godpaper.starling.utils
{

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.utils.describeType;
	/**
	 * That title may be a bit of a stretch, AS3 does not support mixins in the same way as Ruby,</br> 
	 * but it is possible to define a set of methods and/or attributes in a single file 
	 * and then mix those methods and attributes into your AS3 classes.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 16, 2011 3:08:15 PM
	 * @see http://flexonrails.net/?p=73
	 */
	public class MixinUtil
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Copies static and instance methods and properties from mixin to c.
		 **/
		public static function extendClass(c:Class, mixin:Class):void
		{
			var typeDesc:Object=getTypeDesc(mixin);
			copyMethodsAndProps(c, mixin, typeDesc['statics']);
			copyMethodsAndProps(c.prototype, new mixin(), typeDesc['members']);
			copyPrototype(c, mixin);
		}

		/**
		 * Copies static methods and properties from mixin to c.
		 **/
		public static function mixinStatics(c:Class, mixin:Class):void
		{
			copyMethodsAndProps(c, mixin, getTypeDesc(mixin)['statics']);
		}

		/**
		 * Copies instance methods and properties from the mixin's class instance
		 * and the mixin's prototype to c's prototype.
		 **/
		public static function mixinMembers(c:Class, mixin:Class):void
		{
			copyMethodsAndProps(c.prototype, new mixin(), getTypeDesc(mixin)['members']);
			copyPrototype(c, mixin);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private static function copyMethodsAndProps(recipient:Object, source:Object, methodsAndProps:Object):void
		{
			for each (var method:String in methodsAndProps['methods'])
				recipient[method]=source[method];

			for each (var prop:String in methodsAndProps['properties'])
				recipient[prop]=source[prop];
		}

		//
		private static function copyPrototype(recipient:Class, source:Class):void
		{
			for (var protoProp:String in source.prototype)
				recipient.prototype[protoProp]=source.prototype[protoProp];
		}

		//
		private static function getTypeDesc(c:Class):Object
		{
			var desc:XML=describeType(c);
			var staticMethods:Array=[];
			var staticProperties:Array=[];
			var memberMethods:Array=[];
			var memberProperties:Array=[];

			for (var f:String in desc.method)
				staticMethods.push(desc.method.@name[f]);

			for (var l:String in desc.variable)
				staticProperties.push(desc.variable.@name[l]);

			for (var e:String in desc.factory.method)
				memberMethods.push(desc.factory.method.@name[e]);

			for (var x:String in desc.factory.variable)
				memberProperties.push(desc.factory.variable.@name[x]);

			return {statics: {methods: staticMethods, properties: staticProperties}, members: {methods: memberMethods, properties: memberProperties}};
		}
	}

}