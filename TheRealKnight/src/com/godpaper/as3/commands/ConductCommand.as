package com.godpaper.as3.commands
{
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.messages.ConductMessage;
	import com.godpaper.as3.services.IConductService;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * ConductCommand.as class.
	 * /*********************************************************
	 * This is a short lived dynamic command class.  In parsley Commands are
	 * normaly created when a message is dispatched of it's expecting type.
	 * Once created the execute method is called and passed the argument.
	 * This command injects a service interface and proceeds to call
	 * the service methods.
	 * Once the command completes it is automatically destroyed unless specifically told not to.
	 *
	 * For more Parsley and Flex Examples visit artinflex.blogspot.com 	 *
	 * /*********************************************************
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 15, 2011 4:26:56 PM
	 */   	 
	public class ConductCommand
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/*********************************
		 * The service is injected through an Interface.  This makes it easy
		 * to swap out the service with a different class.  Parsley figures
		 * automatically out through reflection wich of it's manage object
		 * should it inject by determining which classes implement this
		 * interface.
		 */    
		[Inject]
		public var service:IConductService;
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
		/*********************************
		 * Once Parsley creates this command object and performs it's injections,
		 * it proceeds to call the execute method.  You can tell Parsley to call
		 * a different method, but this is discouraged.  The execute method
		 * can return an AsyncObject.
		 * Parsley determines which command to execute by the object
		 * type of the parameter of this execute method.
		 *
		 * @param message is the message sent.  It's type is used to determine
		 * which command to execute.
		 */        
		public function execute (message:ConductMessage) : void
		{
			if(!service.connected)
			{
				service.initialization(DefaultConstants.CIRRUS_SERVER,DefaultConstants.CIRRUS_DEV_KEY);
			}else
			{
				service.transforBrevity(message.brevity);
			}
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

