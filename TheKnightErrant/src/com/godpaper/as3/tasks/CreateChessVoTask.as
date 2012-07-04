package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.views.components.ChessPiece;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * CreateChessVoTask.as class. include<conduct,omen,etc..>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 12:04:11 PM
	 */   	 
	public class CreateChessVoTask extends ChessTaskBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
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
		public function CreateChessVoTask(factory:Class=null)
		{
			super();
			//Set properties
			this.label = "CreateChessVoTask";
			//
			if(factory)
			{
				this.factory = factory;
			}
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
		override protected function performTask():void
		{
			var className:String = getQualifiedClassName(factory);
			var implementation:Object = getDefinitionByName(className);
			var realFactoy:IChessFactory  = new implementation();
			//create chess pieces' conductVO;
			//create chess pieces' omenVO;
			for(var cp:int=0;cp<chessPiecesModel.pieces.length;cp++)
			{
				var chessPiece:ChessPiece = chessPiecesModel.pieces[cp];
				//generateChessPieceVO
				var conductVO:ConductVO = new ConductVO();
				conductVO.target = chessPiece;
				conductVO.previousPosition = chessPiece.position;
				chessPiece.chessVO = realFactoy.generateChessVO(conductVO);
				//generateOmenVO
				var omenVO:OmenVO = realFactoy.generateOmenVO(conductVO);
//				LOG.debug(omenVO.dump());
				chessPiece.omenVO = omenVO;
			}
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

