package com.lookbackon.AI.evaluation
{
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;

	/**
	 * An <b>evaluation</b> function is used to heuristically determine the relative value of a position, 
	 * i.e. the chances of winning. </br>
	 * If we could see to the end of the game in every line, 
	 * the evaluation would only have values of -1 (loss), 0 (draw), and 1 (win). </br>
	 * In practice, however, we do not know the exact value of a position, 
	 * so we must make an approximation. </br>
	 * Beginning chess players learn to do this starting with the value of the pieces themselves. </br>
	 * Computer evaluation functions also use the value of the material as the most significant aspect 
	 * and then add other considerations.</br>
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IEvaluation
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		function doEvaluation(conductVO:ConductVO,gamePosition:PositionVO):int;
	}
}