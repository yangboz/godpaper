package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.as3.views.components.PiecesBox;
	
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.display.DisplayObject;
	

	/**
	 * FillInPiecesBoxTask.as class.Actually it with "put on" busniess logic.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 8, 2011 12:34:16 PM
	 */   	 
	public class FillInPiecesBoxTask extends ChessTaskBase
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
		public function FillInPiecesBoxTask()
		{
			super();
			//Set properties
			this.label = "FillInPiecesBoxTask";
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override protected function performTask():void
		{
			var className:String = getQualifiedClassName(factory);
			var implementation:Object = getDefinitionByName(className);
			var realFactoy:IChessFactory  = new implementation();
			var defaultPoint:Point = new Point(-1,-1);
			//create chess piece by type
			//blue
			for(var i:int=0;i<PieceConfig.bluePieces.length;i++)
			{
				var iChessPiece:IChessPiece = realFactoy.createChessPiece(defaultPoint,DefaultConstants.FLAG_BLUE);
				if(iChessPiece!=null)
				{
//					(PieceConfig.bluePiecesBox as PiecesBox).addElement( iChessPiece );
//					(PieceConfig.bluePiecesBox as PiecesBox).addChild( DisplayObject(iChessPiece) );//view ref
					FlexGlobals.gameStage.addChild(DisplayObject(iChessPiece));//view ref
					PieceConfig.bluePiecesBox.chessPieces.push(iChessPiece as ChessPiece);//model ref
					//
					iChessPiece.x = getRandomX((PieceConfig.bluePiecesBox as PiecesBox));
					iChessPiece.y = getRandomY((PieceConfig.bluePiecesBox as PiecesBox));
					//
					(iChessPiece as ChessPiece).originalX = iChessPiece.x;
					(iChessPiece as ChessPiece).originalY = iChessPiece.y;
					(iChessPiece as ChessPiece).piecesBox = PieceConfig.bluePiecesBox as PiecesBox;
				}
			}
			//red
			for(var j:int=0;j<PieceConfig.redPieces.length;j++)
			{
				var jChessPiece:IChessPiece = realFactoy.createChessPiece(defaultPoint,DefaultConstants.FLAG_RED);
				if(jChessPiece!=null)
				{
//					(PieceConfig.redPiecesBox as PiecesBox).addElement( jChessPiece );
//					(PieceConfig.redPiecesBox as PiecesBox).addChild( DisplayObject(jChessPiece) );//view ref
					FlexGlobals.gameStage.addChild(DisplayObject(jChessPiece));//view ref
					PieceConfig.redPiecesBox.chessPieces.push(jChessPiece as ChessPiece);//model ref
					//
					jChessPiece.x = getRandomX((PieceConfig.redPiecesBox as PiecesBox));
					jChessPiece.y = getRandomY((PieceConfig.redPiecesBox as PiecesBox));
					//
					(jChessPiece as ChessPiece).originalX = jChessPiece.x;
					(jChessPiece as ChessPiece).originalY = jChessPiece.y;
					(jChessPiece as ChessPiece).piecesBox = PieceConfig.redPiecesBox as PiecesBox;
				}
			}
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		protected function getRandomX(sponsor:PiecesBox):Number
		{
//			return MathUtil.transactRandomNumberInRange(0,sponsor.width);
			var gPoint:Point = sponsor.localToGlobal(new Point(sponsor.childrenArea.x,sponsor.childrenArea.y));
			return MathUtil.transactRandomNumberInRange(sponsor.x,(sponsor.x+sponsor.childrenArea.width));
		}
		protected function getRandomY(sponsor:PiecesBox):Number
		{
//			return MathUtil.transactRandomNumberInRange(0,sponsor.height);
			var gPoint:Point = sponsor.localToGlobal(new Point(sponsor.childrenArea.x,sponsor.childrenArea.y));
			return MathUtil.transactRandomNumberInRange(sponsor.y,(sponsor.y+sponsor.childrenArea.height));
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}