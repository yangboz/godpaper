/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.godpaper.as3.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
    import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.display.Stage;
import starling.textures.Texture;

	/**
	 * Customize chess piece's Drag-and-Drop inside of AS3/starling system. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created May 29, 2012 1:38:23 PM
	 * @see http://masputih.com/2010/05/creating-drag-and-drop-for-as3-isolib
	 */   	 
	public class ChessPieceDragManager
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _proxy:Sprite;
        private var _view:Stage;
        private var _obj:DisplayObject;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get obj():DisplayObject { return _obj; }
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
        public function ChessPieceDragManager(enf:SingletonEnforcer) 
        {
        }
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function drag(obj:DisplayObject, view:Stage):void
        {
            _view = view;
            _obj = obj;
			//
			var bmpd:BitmapData = new BitmapData(_obj.width,_obj.height);
            var bmp:Bitmap = new Bitmap(bmpd);
            bmp.x = -_obj.width;
            bmp.y = -_obj.height;
			var texture:Texture = Texture.fromBitmap(bmp);
			var img:Image = new Image(texture);
            //
            _proxy = new Sprite();
            _proxy.alpha = .5;
            _proxy.addChild(img);
            _proxy.addEventListener(Event.ENTER_FRAME, onProxyEnterFrame);
            _view.addChild(_proxy);
            
            _view.stage.addEventListener(MouseEvent.MOUSE_UP, drop);
        }
        //
        private function onProxyEnterFrame(event:Event):void 
        {
            if (_proxy != null)
            {
//                _proxy.x = _view.mouseX;
//                _proxy.y = _view.mouseY;
            }
        }
        //
        private function drop(event:Event = null):void
        {
            var p:Point = new Point(_proxy.x, _proxy.y);
            p = _view.localToGlobal(p);
	        //    
			_obj.x = p.x;
			_obj.y = p.y;
			//	            _obj.moveTo(p.x, p.y, 0);
	            
            //clean up
            _view.removeChild(_proxy);
            _view.stage.removeEventListener(MouseEvent.MOUSE_UP, drop);
            _proxy.removeEventListener(Event.ENTER_FRAME, onProxyEnterFrame);
            _proxy = null;
        }

		/**********************************************
         * SINGLETON CTOR
         **********************************************/
        private static var _instance:ChessPieceDragManager;
        public static function getInstance():ChessPieceDragManager
		{
	            if(_instance == null) _instance = new ChessPieceDragManager(new SingletonEnforcer());
	            return _instance;
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
class SingletonEnforcer{};   