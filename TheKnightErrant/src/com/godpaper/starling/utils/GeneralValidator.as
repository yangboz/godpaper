package com.godpaper.starling.utils
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import mx.validators.Validator;
	import mx.validators.ValidationResult;

	/**
	 * GeneralValidator.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 10, 2010 11:57:06 AM
	 */
	public class GeneralValidator extends Validator
	{

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//You may either accept certain values and reject all others,
		//or reject certain values and accept all others.
		//We're too lazy to make sure you don't specify both, but don't.
		[Inspectable]
		public var acceptedValues:Array=null;

		[Inspectable]
		public var rejectedValues:Array=null;

		[Inspectable]
		public var errorMessage:String="Invalid option selected!!!";

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
		public function GeneralValidator()
		{
			//TODO: implement function
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function doValidation(value:Object):Array
		{
			var results:Array=super.doValidation(value);

			var invalid:Boolean=false;

			if (acceptedValues)
			{
				if (acceptedValues.indexOf(value) == -1)
					invalid=true;
			}
			else if (rejectedValues)
			{
				if (rejectedValues.indexOf(value) != -1)
					invalid=true;
			}

			if (invalid)
			{
				results.push(new ValidationResult(true, "", "", errorMessage));
			}

			return results;
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

