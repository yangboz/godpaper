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
package com.godpaper.as3.business
{
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.serialization.PGN;
	import com.godpaper.as3.serialization.PGNDecoder;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.logging.ILogger;
	import mx.utils.StringUtil;
	
	import org.osflash.signals.natives.NativeSignal;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The Proxy pattern does not have different class diagrams for the different types of proxies.  	
	 * @see http://www.as3dp.com/2008/08/actionscript-proxy-design-pattern-the-virtual-proxy-a-minimal-abstract-example/
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 6, 2012 10:48:31 AM
	 */   	 
	public class PGN_Proxy
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var request:URLRequest;
		private var loader:URLLoader;//interface of IEventDispatcher
		//
		private var loadedSignal:NativeSignal;
		private var progressSignal:NativeSignal;
		private var ioErrorSignal:NativeSignal;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PGN_Proxy);
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
		public function PGN_Proxy()
		{
			//
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function load(pgnSrc:String):void
		{
			if(null==loader)
			{
				//			var request:URLRequest = new URLRequest("http://www.lookbackon.com/resources/N01_for_testing.PGN");
				this.loader = new URLLoader();
			}
			//
			request = new URLRequest(pgnSrc);
			//
			var signalTarget:IEventDispatcher = loader;
			loadedSignal = new NativeSignal(signalTarget,Event.COMPLETE,Event);
			loadedSignal.addOnce(pgnLoadedHandler);
			progressSignal = new NativeSignal(signalTarget,ProgressEvent.PROGRESS,ProgressEvent);
			progressSignal.addOnce(pgnProgressHandler);
			ioErrorSignal = new NativeSignal(signalTarget,IOErrorEvent.IO_ERROR,IOErrorEvent);
			ioErrorSignal.addOnce(pgnIoErrorHandler);
			//
			loader.load(request);
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
		//
		private function pgnIoErrorHandler(event:IOErrorEvent):void
		{
			progressSignal.removeAll();
			// 			trace(event.toString());
		}
		//
		private function pgnProgressHandler(event:ProgressEvent):void
		{
			//			trace((event.bytesLoaded / event.bytesTotal) * 100);
		}
		//
		private function pgnLoadedHandler(event:Event):void
		{
			loadedSignal.removeAll();
			LOG.info(event.target.data);
			var _pgnStr:String = StringUtil.trim(event.target.data);	
//			var _pgnStr:String = PGN.decode(event.target.data);	
//			LOG.info(_pgnStr);
			//
			var parser:PGN_Parser = new PGN_Parser(_pgnStr);
			parser.parse();
			//
		}
	}
	
}