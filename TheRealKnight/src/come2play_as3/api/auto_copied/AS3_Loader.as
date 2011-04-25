package come2play_as3.api.auto_copied{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
/**
 * We use a pause mechanism in case the flash is overloaded.
 *
 * Important: Loader has a garbage-collection bug.
 * If you do:
 * var loader:Loader = new Loader();
 * ...
 * and do not store a reference to loader, then it might be garbage collected 
 * (even if it has event listeners!)
 * In this file we create a Loader twice, 
 * and we pass the loader object to its event handlers to prevent garbage collection.
 *  
 * todo: if the image loaded is a BitMap, 
 * then we should use Loader instead of URLLoader,
 * and cache the bitmapData and return a new BitMap:
 * var loader:Loader = new Loader();
   when loaded:
    // loadEvent.target as LoaderInfo;
 	var loadedImage:Bitmap = loader.getChildAt(0) as Bitmap;
	var copyImage:DisplayObject = new Bitmap(loadedImage.bitmapData);
   This will save a lot of space if the image is used many times on the stage
   (or if we have a memory leak) 
   private static var bitmapCache:Dictionary
   we need to change our loading mechanism, and instead of a Loader, return directly a: 
   * DisplayObject/XML/URLVariables
   Currently we have code duplication in the successHandler(loadEvent:Event) {
   	var loader:LoaderInfo = loadEvent.target as LoaderInfo;			
	var child:DisplayObject = loader.content;
	...
	 

todo:  
After all the games are recompiled:
1) Delete using the Loader (always use  "URLLoader")
2) use one place to add  "domainURL", and one place you do caching (be careful not to cache ASP pages, like the one returning the current number of players in igoogle)
3) In addition to size, show also:  startedLoadingOn=... ,  loadingTook=...,  fromCache=true/false

21 images cached:
            http://static.come2play.net/Shared/swf/components/Analytic/Analytic.swf (size=56138)
            http://static.come2play.net/shared/avatars/2009_6/84607912.jpg (size=6931)

4) Analytics for files bigger than 20KB.   Use a SharedObject to predict if the file was in cache or not.
5) When loading images (not SWFs), you can share the BitMapData content  (see my comment in the top of AS3_Loader)

 */
public final class AS3_Loader
{
	private static var LOG:Logger = new Logger("Loader",20);
	private static var Progress_LOG:Logger = new Logger("Progress_LOG",40);
	private static var SUCCESS_RETRY_LOG:Logger = new Logger("SUCCESS_RETRY",10);
	public static function tmpTrace(...args):void {
		LOG.log(args);
	}
	
	private static var EMPTY_BYTE_ARRAY:ByteArray = new ByteArray();	
	public static function getImageLoadByteArray(ev:Event):ByteArray {
		var loadedImage:URLLoader = ev.target as URLLoader;
		StaticFunctions.assert(loadedImage!=null || ev is TimerEvent, "loadedImage is null", ev, ev.target);	
		var res:ByteArray = loadedImage!=null ? loadedImage.data : null;
		// res can be null for 2032 Stream Error or for 2048 securityError
		return res==null ? EMPTY_BYTE_ARRAY : res;
	}
	public static function isImageLoadFailed(ev:Event):Boolean {
		return getImageLoadByteArray(ev).length==0 || (ev is IOErrorEvent); 
	}
	
	
	private static var imageCache:Dictionary/*imageUrl->Event (if loading failed, then the ev.data is an empty ByteArray)*/ = new Dictionary();
	private static var url2RequestArray:Dictionary/*imageUrl->ImageLoadRequest[]*/ = new Dictionary();
	private static var pauseQueue:Array/*ImageLoadRequest*/ = null;
	public static var imageLoadingRetry:int = 3;
	
	private static var AS3_Loader_LOG:Logger = new Logger("AS3_Loader",5);	
	{
		AS3_Loader_LOG.hugeLog(new AS3_Loader());
	}		
	public function toString():String {		
		var url:String
		
		var cachedRes:Array = [];
		var totalSize:int = 0;
		for (url in imageCache) {	
			var ev:Event = imageCache[url];
			var size:int = isImageLoadFailed(ev) ? 0:getImageLoadByteArray(ev).length;
			cachedRes.push(url+
				(!isImageLoadFailed(ev) ? " (size="+size+")" : " (FAILED: "+ev+")"));
			totalSize+=size;
		}
		cachedRes.sort();
		
		var requestRes:Array = [];
		for (url in url2RequestArray) {
			var arr:Array = url2RequestArray[url];
			requestRes.push(url+" #queue="+arr.length); 
		}
		requestRes.sort();
		
		var res:Array = [];
		res.push(AS3_vs_AS2.dictionarySize(imageCache) + " images cached:");
		StaticFunctions.pushAll(res,cachedRes);
		res.push("\t"+AS3_vs_AS2.dictionarySize(url2RequestArray) + " images in queue:");
		StaticFunctions.pushAll(res,requestRes);
		return  res.join("\n\t\t\t")+
			// pauseQueue might be null
			"\npauseQueue="+pauseQueue+" #totalSize="+totalSize;
	}
	
	public static function object2URLVariables(msg:Object):URLVariables {
		var vars:URLVariables = new URLVariables();
		for (var k:String in msg) 
			vars[k] = msg[k];
		return vars;			
	}
	static public var utfLogger:Logger = new Logger("bytesLoaded",5);
	public static function sendToURL(vars:Object, method:String, url:String, successHandler:Function = null,failureHandler:Function = null, progressHandler:Function = null):void {
		tmpTrace("sendToURL=",url);
		var request:URLRequest = new URLRequest(url);
		request.data = object2URLVariables(vars);
		request.method = method;
		var sendSuccessHandler:Function = function (ev:Event):void {
			var byteArr:ByteArray = ev.target.data;
			StaticFunctions.assert(byteArr!=null && byteArr.length>0,"Illegal result on success",ev);
			var res:String =  byteArr.readUTFBytes(byteArr.length);
			utfLogger.log(res)
			ev.target.data =res
			successHandler( ev );
		};
		request.url = getURL(request.url)
		loadURL(request,sendSuccessHandler,failureHandler,progressHandler)
	}
 
 	// are we using Loader or URLLoader?
 	// It is better to use a URLLoader (because once we used Loader, it failed, but still loaded two instances of a game) 		
    public static function removeQueryString(url:String):String {
    	var indexOfQuestionMark:int = url.indexOf("?");
    	return indexOfQuestionMark==-1 ? url : url.substr(0, indexOfQuestionMark);
    }
	
	public static var domainURL:String = "";	
	public static function getURL(url:String):String{
		if (url.substr(0,1) == "/"){
			var cutIndex:int = domainURL.indexOf("/",8);
			StaticFunctions.assert(cutIndex>=8, "Illegal url or domain!",[url,domainURL]);
			return domainURL.substring(0,cutIndex) + url;
		}
		if (url.substr(0,7) == "http://") {
			return url;
		}
		return domainURL + url;
	}
	public static function enterPause():void {
		if (pauseQueue!=null) return;
		tmpTrace("enterPause");
		pauseQueue = [];
	}
	public static function exitPause():void {
		if (pauseQueue==null) return;
		tmpTrace(["exitPause. #pauseQueue=",pauseQueue.length]);
		var copyPause:Array = pauseQueue;
		pauseQueue = null; // we must exit the pause before calling loadImageReq
		for each (var req:ImageLoadRequest in copyPause)
			loadImageReq(req);
	}
	public static var imageFailedFunc:Function
	public static function loadImage(imageUrl:String,successHandler:Function = null,failureHandler:Function = null,progressHandler:Function = null,context:LoaderContext = null,justCach:Boolean = false):void {
		if(T.custom("strictMode",true) as Boolean){
			if(imageUrl.indexOf("preventCache") == -1){
				StaticFunctions.assert((imageUrl.indexOf("?") == -1),"can't pass parameters to a loaded image",imageUrl);
			}
			var imageBreak:Array = imageUrl.split(".");
			var end:String = imageBreak[imageBreak.length - 1]
			end = end.toLowerCase()
			StaticFunctions.assert((end.indexOf("jpeg") == -1 )||(end.indexOf("jpg") == -1 )||(end.indexOf("swf") == -1 )||(end.indexOf("gif") == -1 )||(end.indexOf("png") == -1 ),"ileageal image type")
		}
		StaticFunctions.assert(imageUrl!="" && imageUrl!=null,"can't load a blank image");
		imageUrl = getURL(imageUrl);
		if (failureHandler==null) {
			failureHandler = function(ev:Event):void {
				if(imageFailedFunc!=null)	imageFailedFunc(imageUrl)
				criticalError(ev,imageUrl);
			};			
		}
		if(successHandler == null) {
			successHandler = traceHandler
		}			
		var urlRequest:URLRequest = new URLRequest(imageUrl)
		
		var loadRequest:ImageLoadRequest = new ImageLoadRequest();
		loadRequest.imageURLRequest = urlRequest;
		loadRequest.successHandler = successHandler;
		loadRequest.failureHandler = failureHandler;
		loadRequest.progressHandler = progressHandler;
		loadRequest.context = context;
		loadRequest.justCach = justCach;
		loadImageReq(loadRequest);		
	}
	private static function loadImageReq(loadRequest:ImageLoadRequest):void {
		var imageUrlRequest:URLRequest = loadRequest.imageURLRequest;
		var progressHandler:Function = loadRequest.progressHandler;
		var context:LoaderContext = loadRequest.context; 
		tmpTrace(["Started handling image: ", imageUrlRequest.url, "reqId=", loadRequest.reqId]); 
		var url:String = imageUrlRequest.url
		// caching mechanism
		if (imageCache[url] != null) {
			StaticFunctions.assert(url2RequestArray[url]==null,"url2RequestArray must be empty: ",[url]);
			// image already finished loading			
			handleExistingImage(imageCache[url],loadRequest);
		} else {
			// image not loaded yet
			if (pauseQueue!=null) {
				pauseQueue.push(loadRequest);	
				return;
			}		
			var requestArray:Array/*ImageLoadRequest*/ = url2RequestArray[url];
			if (requestArray==null) {
				// the first time we try to load imageUrl
				requestArray = [];
				url2RequestArray[url] = requestArray;
			}
			requestArray.push(loadRequest);
			if (requestArray.length==1) {		
				loadURL(imageUrlRequest,
					// success function
					function(ev:Event):void {
						loadedImageUrl(false, url,ev);						
					},
					// failure function
					function(ev:Event):void {
						loadedImageUrl(true, url,ev);						
					},progressHandler,context);		
			}
		}		
	}
	private static function loadedImageUrl(isFailure:Boolean, imageUrl:String, ev:Event):void {
		tmpTrace(["loadedImageUrl isFailure=",isFailure," imageUrl=",imageUrl, " event=",ev]);
						
				
		StaticFunctions.assert(isFailure==isImageLoadFailed(ev), "loadedImageUrl failure mismatch",["isFailure=", isFailure, imageUrl, ev]);
		for each (var req:ImageLoadRequest in url2RequestArray[imageUrl]) {
			handleExistingImage(ev,req);		
		}
		
		StaticFunctions.assert(imageCache[imageUrl]==null,"imageCache must be empty",[imageUrl]);
		// even if loading failed, 
		// we put the event to prevent future attempts to load the image again
		imageCache[imageUrl] = ev;
		delete url2RequestArray[imageUrl];
	}
	private static var PREVENT_GC:Dictionary = new Dictionary();
	private static function handleExistingImage(ev:Event,req:ImageLoadRequest):void{		
		tmpTrace(["Loaded image: ", req.imageURLRequest.url, "reqId=", req.reqId, "ev=",ev]);
		if(req.justCach){
			req.justCach = false;
			return;
		}	
		if (isImageLoadFailed(ev)) {
			// previous loading failed 
			req.failureHandler(ev);
		} else {
			var data:ByteArray = getImageLoadByteArray(ev);
			StaticFunctions.assert(data.length>0,"Internal error: image loading did not fail, so data.length>0!",[])
			var byteConverter:Loader = new Loader();
			PREVENT_GC[byteConverter] = true;
			var dispatcher:IEventDispatcher = byteConverter.contentLoaderInfo;
			// IMPORTANT - there was a garbage collection issue here (if I remove the anonymous function and replace it with req.successHandler)
			// therefore the event listener must refer to byteConverter to prevent it from being garbage-collected			
			var failureFunc:Function = function (ev:Event):void { removeImageLoaderListeners(byteConverter,dispatcher,req,ev,true); };
			var successFunc:Function = function (ev:Event):void { removeImageLoaderListeners(byteConverter,dispatcher,req,ev,false); };
			AS3_vs_AS2.myAddEventListener("handleExistingImage", dispatcher,Event.COMPLETE, successFunc); 
			var errorEvents:Array/*String*/ = [IOErrorEvent.IO_ERROR, HTTPStatusEvent.HTTP_STATUS, SecurityErrorEvent.SECURITY_ERROR];
			for each (var errorEvent:String in errorEvents)
				AS3_vs_AS2.myAddEventListener("handleExistingImage", dispatcher, errorEvent, failureFunc);
				
			var context:LoaderContext = null;
			if (req.context!=null) {
				context = new LoaderContext(false, req.context.applicationDomain); 
			}  
			byteConverter.loadBytes(data,context);
		}
	}
	private static function removeImageLoaderListeners(byteConverter:Loader, dispatcher:IEventDispatcher, req:ImageLoadRequest, ev:Event, isFailure:Boolean):void {
		delete PREVENT_GC[byteConverter];
		AS3_vs_AS2.myRemoveAllEventListeners("handleExistingImage", dispatcher);
		tmpTrace(["COMPLETED handling image: ", req.imageURLRequest.url, "reqId=", req.reqId, " res=",byteConverter.content, " isFailure=",isFailure, "event=",ev]);
		if (isFailure)
			req.failureHandler(ev);
		else
			req.successHandler(ev);
	}

	
	public static var EVENT_DATA_DEBUG_LEN:int = 1000;
	public static var TIMEOUT_TIMER_MILLI:int = 30000;
	private static function loadURL(urlRequest:URLRequest,successHandler:Function = null,failureHandler:Function = null,progressHandler:Function = null,context:LoaderContext = null, retryCount:int=0,calledFrom:String="undefined"):void{
		StaticFunctions.assert( retryCount<imageLoadingRetry, "Internal error in loadURL",[]);
		tmpTrace("trying to load : ",urlRequest.url, " retryCount=",retryCount);
		if (successHandler == null){
			successHandler = traceHandler
		}
		if (failureHandler==null) {			
			failureHandler = function (ev:Event):void {criticalError(ev,urlRequest.url);};			
		}	
		//The Loader class is used to load SWF files or image (JPG, PNG, or GIF) files.  
		//Use the URLLoader class to load text or binary data.
		var dispatcher:IEventDispatcher;	
		var urlloader:URLLoader;
		// using URLLoader
		urlloader = new URLLoader();	
		urlloader.dataFormat = URLLoaderDataFormat.BINARY;
		dispatcher = urlloader;
				
		// garbage-collection bug: we must refer to loader to prevent it from being garbage-collected!
		var failTimer:AS3_Timer = new AS3_Timer("LoadFailTimer",TIMEOUT_TIMER_MILLI);	
		var newSuccFunction:Function = function (ev:Event):void { removeLoadUrlListeners(false,urlRequest,dispatcher,ev,successHandler, failureHandler,progressHandler, context, retryCount,failTimer); };
		var newFailFunction:Function = function (ev:Event):void { removeLoadUrlListeners(true ,urlRequest,dispatcher,ev,successHandler, failureHandler,progressHandler, context, retryCount,failTimer); };
		AS3_vs_AS2.myAddEventListener("failTimer",failTimer,TimerEvent.TIMER, newFailFunction); 
		
		var traceFunc:Function = function (ev:Event):void {
			// HTTPStatusEvent.responseHeaders are only available in AdobeAir
			tmpTrace("Only tracing (for debugging purposes) event for ",urlRequest.url, "event=",ev); 
		};
		var allTraceEvents:Array = [Event.ACTIVATE, Event.DEACTIVATE,Event.INIT,Event.OPEN,Event.UNLOAD,HTTPStatusEvent.HTTP_STATUS];			
		for each (var event:String in allTraceEvents)
			AS3_vs_AS2.myAddEventListener("loadURL",dispatcher,event, traceFunc); 			
			
		AS3_vs_AS2.myAddEventListener("loadURL",dispatcher,Event.COMPLETE, newSuccFunction); 
		AS3_vs_AS2.myAddEventListener("loadURL",dispatcher,IOErrorEvent.IO_ERROR, newFailFunction);
    	AS3_vs_AS2.myAddEventListener("loadURL",dispatcher, SecurityErrorEvent.SECURITY_ERROR, newFailFunction);
    	  
    	var newProgressHandler:Function = function(ev:ProgressEvent):void{
    		Progress_LOG.log("progress in:",urlRequest.url,"ev=",ev)
    		if(progressHandler !=null)	progressHandler(ev);
    		failTimer.reset();
    		failTimer.start();
    	};	    	
		AS3_vs_AS2.myAddEventListener("loadURL",dispatcher,ProgressEvent.PROGRESS,newProgressHandler)
  		try {
	  		urlloader.load(urlRequest);
     	} catch(error:Error) {
     		var ev:Event = new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR,false, false, AS3_vs_AS2.error2String(error));
     		removeLoadUrlListeners(true, urlRequest,dispatcher,ev,successHandler, failureHandler,progressHandler, context, retryCount,failTimer);
     	}		
	}
	public static var RETRY_DELAY_MILLI:int = 3000;
	public static var MIN_LEN:int = 3;
	private static function removeLoadUrlListeners(isFailure:Boolean, urlRequest:URLRequest,dispatcher:IEventDispatcher, ev:Event, successHandler:Function,failureHandler:Function, progressHandler:Function,context:LoaderContext, retryCount:int,failTimer:AS3_Timer):void {
		// I don't use the loader, but I still pass it to prevent garbage collection
		failTimer.stop();
		AS3_vs_AS2.myRemoveAllEventListeners("failTimer",failTimer)	
		AS3_vs_AS2.myRemoveAllEventListeners("loadURL", dispatcher);
		var data:Object	= null;
		if (ev!=null && ev.target!=null && ev.target.hasOwnProperty("data")) data = ev.target.data;
		var len:int = data==null ? int.MAX_VALUE : // null is a legal case! e.g., (todo: find an example)
			data is String ? (data as String).length : 
			data is ByteArray ? (data as ByteArray).length : 
			-1;
		StaticFunctions.assert(len>=0, "Loaded an illegal type for data: ",data);
			
		if (len<=MIN_LEN) {
			tmpTrace("We loaded a String/ByteArray which are too small! so we retry to load the image again");
			isFailure = true;
		}
								
		tmpTrace("loaded url=",urlRequest," isFailure=",isFailure," event=",ev, " len=",len, " ev.target.data=", 
			// if you load a SWF, then .data is a very long $ByteArray$ "arr":[67,87...] 
			data==null ? 			"no ev.target.data" :
			data is String ? 		StaticFunctions.cutString(data as String,EVENT_DATA_DEBUG_LEN)  : 
						  			"ByteArray");
		if (!isFailure) {
			if (retryCount>0){
				 SUCCESS_RETRY_LOG.log("Retry mechanism worked for url=",urlRequest.url);
				 AS3_GATracker.COME2PLAY_TRACKER.trackEvent("Loading","Image Loading","Succeded retry "+retryCount+" on "+removeQueryString(urlRequest.url),1)
			}
			tmpTrace("calling successHandler=",successHandler)
			successHandler(ev);
		} else {
			AS3_GATracker.COME2PLAY_TRACKER.trackEvent("Loading","Image Loading","Failed retry "+retryCount+" on "+removeQueryString(urlRequest.url),1)
			if (dispatcher is URLLoader)  {
				try{
					var urlLoader:URLLoader = (dispatcher as URLLoader)
					urlLoader.close();
				}catch(err:Error){
					tmpTrace(err,"Stream was already closed for ",urlLoader);
				}
			}		
			if (retryCount+1<imageLoadingRetry) {
				tmpTrace("We retry to load the url=",urlRequest,"retry delay is",RETRY_DELAY_MILLI);
				var urlString:String = urlRequest.url;
				urlString+=((urlString.indexOf("?") == -1)?"?":"&")+"preventCache="+int(Math.random()*int.MAX_VALUE)
				urlRequest.url = urlString;
				ErrorHandler.myTimeout("RetryDelay",function():void {
					loadURL(urlRequest,successHandler,failureHandler,progressHandler,context,retryCount+1);
				},RETRY_DELAY_MILLI);
			} else {
				failureHandler(ev);
			}
		}
	}
	
	
	public static function traceHandler(e:Event):void {
        // we already do tracing in tmpTrace
    }
	public static function criticalError(ev:Event,url:String):void{
		tmpTrace(" Error loading URL: ",url)
		var msg:String;
		if(ev is IOErrorEvent){
			msg = "critical IOErrorEvent" + JSON.stringify(ev as IOErrorEvent);
		}else if(ev is SecurityErrorEvent){
			msg = "critical SecurityErrorEvent" + JSON.stringify(ev as SecurityErrorEvent);	
		}
		ErrorHandler.alwaysTraceAndSendReport(msg, [url,ev]);
		StaticFunctions.showError(msg+" in url="+url);
	}

}
}
import flash.system.LoaderContext;
import flash.net.URLRequest;
class ImageLoadRequest {
	public static var CURR_REQ_ID:int = 1; 
	public var reqId:int = CURR_REQ_ID++;
	
	public var justCach:Boolean
	public var imageURLRequest:URLRequest;
	public var context:LoaderContext;
	public var successHandler:Function;
	public var progressHandler:Function;
	public var failureHandler:Function;
	
	public function toString():String {
		return imageURLRequest.url;
	}
}
