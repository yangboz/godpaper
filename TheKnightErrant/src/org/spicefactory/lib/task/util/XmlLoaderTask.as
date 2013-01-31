package org.spicefactory.lib.task.util {
	import com.godpaper.as3.utils.LogUtil;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.logging.ILogger;
	
	import org.spicefactory.lib.task.ResultTask;
	import org.spicefactory.lib.task.enum.TaskState;

public class XmlLoaderTask extends ResultTask {
	
	
//	private static const _log:Logger = LogContext.getLogger("org.spicefactory.parsley.loader.XmlLoaderTask");
	private static const _log:ILogger = LogUtil.getLogger(XmlLoaderTask);
	
	private var _filename:String;
	private var _loader:URLLoader;
	
	private var _xml:XML;
	
	
	public function XmlLoaderTask (filename:String) {
		_filename = filename;	
		setSuspendable(false);
		setSkippable(false);
	}
	
	
	protected override function doStart () : void {
		_log.info("Start " + this);
		_loader = new URLLoader();
		_loader.addEventListener(Event.COMPLETE, onComplete);
		_loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorEvent);
		_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorEvent);
		_loader.dataFormat = URLLoaderDataFormat.TEXT;
		_loader.load(new URLRequest(_filename));
	}
	
	protected override function doCancel () : void {
		_loader.close();
		_xml = null;
	}
	
	private function onComplete (evt:Event) : void {
		if (state != TaskState.ACTIVE) return;
		_log.info("Loaded XML File " + _filename);
		var str:String = _loader.data;
		try {
			var xml:XML = new XML(str);
		} catch (e:Error) {
			var msg:String = "XML Parser error: " + e.message;
			_log.error(msg);
			onError(msg);
			return;
		}
		_xml = xml;
		setResult(_xml);
	}
	
	private function onErrorEvent (evt:ErrorEvent) : void {
		onError(evt.text);
	}
	
	private function onError (message:String) : void {
		var str:String = "Error loading " + _filename + ": " + message;
		_log.error(str);
		error(message);
	}
	
	public function get xml () : XML {
		return _xml;
	}	
	
	public override function toString () : String {
		return "[XMLLoader for file: " + _filename + "]";
	}	
	
}

}