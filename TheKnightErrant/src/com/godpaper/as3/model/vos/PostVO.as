package com.godpaper.as3.model.vos
{
	import mx.utils.ObjectUtil;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * PostVO.as class.Abstract to Object wit packaged variables to net group posting.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 18, 2012 2:34:35 PM
	 */   	 
	public class PostVO extends UserVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public var id:String  = new Date().time.toString()+(Math.random()*int.MAX_VALUE).toString();
		public var destination:String = "";//destination peer id.
		public var status:String = null;
		public var state:String = STATE_REG;
		public var brevity:String = null;//brevity text.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const STATE_REG:String = "registry";
		public static const STATE_UPDATE:String = "update";
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
		override public function toString():String
		{
			return  ObjectUtil.toString(this);
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
	}
	
}