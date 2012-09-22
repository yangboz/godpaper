//
//  GP_DefaultConstants.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-9-22.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface GP_DefaultConstants : NSObject
//
//@end

//about chess pieces' flag
#define FLAG_RED 1<<0
#define FLAG_BLUE 1<<1
#define FLAG_GREEN 1<<2
//
#define COLOR_RED @"red" //below;
#define COLOR_BLUE @"blue" //above;
//chess board backgroud
#define IMG_BACK_GROUND @"IMG_BACK_GROUND"
//chess pieces(blue) main type consts
#define BLUE @="BLUE"
#define BLUE_ROCK @"BLUE_ROCK"
#define BLUE_STAR @"BLUE_STAR"
#define BLUE_JEWEL @"BLUE_JEWEL"
//chess pieces(blue) sub type consts
//		public static const BLUE_ROOK:String="BLUE_ROOK";
//		public static const BLUE_KNIGHT:String="BLUE_KNIGHT";
//		public static const BLUE_BISHOP:String="BLUE_BISHOP";
//		public static const BLUE_OFFICAL:String="BLUE_OFFICAL";
//		public static const BLUE_MARSHAL:String="BLUE_MARSHAL";
//		public static const BLUE_CANNON:String="BLUE_CANNON";
//		public static const BLUE_PAWN:String="BLUE_PAWN";
//chess pieces(red) main type consts
#define RED @"RED"
#define RED_ROCK @"RED_ROCK"
#define RED_STAR @"RED_STAR"
#define RED_JEWEL @"BLUE_JEWEL"
//chess pieces(red) sub type consts
//		public static const RED_ROOK:String="RED_ROOK";
//		public static const RED_KNIGHT:String="RED_KNIGHT";
//		public static const RED_BISHOP:String="RED_BISHOP";
//		public static const RED_OFFICAL:String="RED_OFFICAL";
//		public static const RED_MARSHAL:String="RED_MARSHAL";
//		public static const RED_CANNON:String="RED_CANNON";
//		public static const RED_PAWN:String="RED_PAWN";
//chess pieces state label
#define STATE_ATTACK @"Attack"
#define STATE_DEFENCE @"Defence"
#define STATE_NASCENCE @"Nascence"
#define STATE_RENASCENCE @"Renascence"
//game states' label
#define STATE_HUMAN @"HumanTurn"
#define STATE_ANOTHER_HUMAN @"AnotherHumanTurn"
#define STATE_COMPUTER @"ComputerTurn"
#define STATE_HUMAN_WIN @"HumanWin"
#define STATE_COMPUTER_WIN @"ComputerWin"
#define STATE_ANOTHER_HUMAN_WIN @"AnotherHumanWin"
//indications
#define INDICATION_THINK @"Thinking.."
#define INDICATION_CHECK @"Eschequier"
#define INDICATION_COMPUTER_WIN @"Computer Win!!!"
#define INDICATION_HUMAN_WIN @"You Win!!!"
//P2P connnections(Server,DevKey)
//Stratus:rtmfp://stratus.adobe.com/99ead580edaf280c060675f9-f614dd07a932
//Cirrus:rtmfp://p2p.rtmfp.net/40a1c5b634bc4f531ad7757f-2e3cf422214e/
#define CIRRUS_SERVER @"rtmfp://stratus.adobe.com/"//"rtmfp://p2p.rtmfp.net/";
#define CIRRUS_DEV_KEY @"99ead580edaf280c060675f9-f614dd07a932"//"40a1c5b634bc4f531ad7757f-2e3cf422214e";
//Screen ids
#define SCREEN_SPLASH @"screen_splash"
#define SCREEN_MAIN_MENU @"screen_main_menu"
#define SCREEN_GAME @"screen_game"
#define SCREEN_HANDSHAKE @"screen_handshake"
#define SCREEN_SETTINGS @"screen_settings"
//Chess board type
#define CHESS_BOARD_TYPE_INTERSECTION @"ChessBoardType::intersection"//point of intersection
#define CHESS_BOARD_TYPE_CHECKERING @"ChessBoardType::checkering"//mark into squares or draw squares on; draw crossed lines on
#define CHESS_BOARD_TYPE_SEGMENT @"ChessBoardType::segament"//section of line
#define CHESS_BOARD_TYPE_FRACTAL @"ChessBoardType::fractal"//mathematical fractal
//Locale languages
#define LOCALE_LANG_ZH_CN @"zh_CN"
#define LOCALE_LANG_EN_US @"en_US";
#define LOCALE_LANG_KO_KR @"ko_KR";
//Resource bundles
#define LOCLAE_BUNDLE_SCREEN @"screen_resources_";