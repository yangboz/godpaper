package com.godpaper.as3.consts
{

	/**
	 * <b>ChineseChessJam constants as follows:</b></p>
	 * 1.global chess board width and heigt setting;</p>
	 * 2.global chess pieces' flag setting(top is blue(computer),bottom is red(human));</p>
	 * 3.global chess pieces' color setting(blue/red);</p>
	 *
	 * @author Knight.zhou
	 *
	 */
	public class CcjConstants
	{
		//global board config.
//		public static const BOARD_H_LINES:int=9;
//		public static const BOARD_V_LINES:int=10;
		//about board style.
//		public static const BOARD_SCALE_XY:Number=1;
//		public static const BOARD_WIDTH:Number=400 * BOARD_SCALE_XY;
//		public static const BOARD_HEIGHT:Number=450 * BOARD_SCALE_XY;
//		public static const BOARD_LATTICE:Number=50 * BOARD_SCALE_XY;
		//about chess pieces' flag
		public static const FLAG_RED:int=0;
		public static const FLAG_BLUE:int=1;
		public static const FLAG_GREEN:int=2;
		//
		public static const COLOR_RED:String="red"; //above;
		public static const COLOR_BLUE:String="blue"; //below;
		//chess pieces type consts
		public static const BLUE_ROOK:String="BLUE_ROOK";
		public static const BLUE_KNIGHT:String="BLUE_KNIGHT";
		public static const BLUE_BISHOP:String="BLUE_BISHOP";
		public static const BLUE_OFFICAL:String="BLUE_OFFICAL";
		public static const BLUE_MARSHAL:String="BLUE_MARSHAL";
		public static const BLUE_CANNON:String="BLUE_CANNON";
		public static const BLUE_PAWN:String="BLUE_PAWN";
		//
		public static const RED_ROOK:String="RED_ROOK";
		public static const RED_KNIGHT:String="RED_KNIGHT";
		public static const RED_BISHOP:String="RED_BISHOP";
		public static const RED_OFFICAL:String="RED_OFFICAL";
		public static const RED_MARSHAL:String="RED_MARSHAL";
		public static const RED_CANNON:String="RED_CANNON";
		public static const RED_PAWN:String="RED_PAWN";
		//chess pieces state label
		public static const STATE_ATTACK:String="Attack";
		public static const STATE_DEFENCE:String="Defence";
		public static const STATE_NASCENCE:String="Nascence";
		public static const STATE_RENASCENCE:String="Renascence";
		//game states' label
		public static const STATE_HUMAN:String="HumanTurn";
		public static const STATE_ANOTHER_HUMAN:String="AnotherHumanTurn";
		public static const STATE_COMPUTER:String="ComputerTurn";
		public static const STATE_HUMAN_WIN:String="HumanWin";
		public static const STATE_COMPUTER_WIN:String="ComputerWin";
		public static const STATE_ANOTHER_HUMAN_WIN:String = "AnotherHumanWin";
		//indications
		public static const INDICATION_THINK:String="Thinking..";
		public static const INDICATION_CHECK:String="Eschequier";
	}
}

