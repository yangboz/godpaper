package color_lines.src.com.godpaper.color_lines.busniess.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.GameStateManagerDefault;
	import com.godpaper.as3.consts.DefaultConstants;
	import color_lines.src.com.godpaper.color_lines.busniess.fsm.states.game.ComputerState_ColorLines;


	/**
	 * ColorLineGameStateManager.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 13, 2011 2:47:33 PM
	 */
	public class GameStateManager_ColorLines extends GameStateManagerDefault
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
		public function GameStateManager_ColorLines()
		{
			//TODO: implement function
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  isComputerTurnNow
		//----------------------------------
		override public function isComputerTurnNow():void
		{
			//don't forget set turn now flag.
			_roles = TURN_NOW_COMPUTER;
			//delegate fsm transition to computer state.
			agent.fsm.changeState(new ComputerState_ColorLines(agent, null, DefaultConstants.STATE_COMPUTER));
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