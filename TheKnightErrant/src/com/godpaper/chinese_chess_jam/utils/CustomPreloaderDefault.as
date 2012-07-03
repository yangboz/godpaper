package com.godpaper.chinese_chess_jam.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.DropShadowFilter;

	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;

	public class CustomPreloaderDefault extends DownloadProgressBar
	{
		private var cp:CustomPreloader;

		public function CustomPreloaderDefault()
		{
			cp=new CustomPreloader();
			cp.filters=[new DropShadowFilter(4, 45, 0, 0.5)];
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addChild(cp);
		}

		public override function set preloader(preloader:Sprite):void
		{
			preloader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			preloader.addEventListener(FlexEvent.INIT_COMPLETE, initComplete);
		}

		private function onProgress(e:ProgressEvent):void
		{
			cp.percent.text=Math.ceil(e.bytesLoaded / e.bytesTotal * 100).toString() + "%";
			cp.gotoAndStop(Math.ceil(e.bytesLoaded / e.bytesTotal * 100));
		}

		private function initComplete(e:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function onAdded(e:Event):void
		{
			cp.stop();
			cp.x=stage.stageWidth * 0.5 - cp.width * 0.5;
			cp.y=stage.stageHeight * 0.5 - cp.height * 0.5;
			//comment label for avoidnig "textLayout" at resource manager error.
			cp.label.text="";
		}

	}
}

