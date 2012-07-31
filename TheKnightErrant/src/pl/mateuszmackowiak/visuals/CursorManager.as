package pl.mateuszmackowiak.visuals
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;

	public class CursorManager
	{
		[Embed(source="/assets/images/cursors/aero_busy.png")]
		private static var WindowsAreoBusyClass:Class;
		
		[Embed(source="/assets/images/cursors/mac_busy.png")]
		private static var MacBusyClass:Class;
		
		[Embed(source="/assets/images/cursors/linux_busy.png")]
		private static var LinuxBusyClass:Class;
		
		[Embed(source="/assets/images/cursors/windows.png")]
		private static var WindowsBusyClass:Class;
		
		public static const BUSY_CURSOR_NAME:String = "busyCoursor";
		
		
		private static var busyCoursorData:MouseCursorData = null;
		
		public static function setBusyCursor():void
		{
			if(Mouse.supportsNativeCursor){
				if(busyCoursorData==null){
					busyCoursorData = createBusyCoursor();
					Mouse.registerCursor(BUSY_CURSOR_NAME,busyCoursorData);
				}
				Mouse.cursor = BUSY_CURSOR_NAME;
			}
		}
		
		public static function removeBusyCursor():void{
			if(Mouse.cursor == BUSY_CURSOR_NAME){
				Mouse.cursor = "auto";
			}
		}
		private static function createBusyCoursor():MouseCursorData
		{
			var bitmap:Bitmap;
			const os:String = Capabilities.os;
			if(os.indexOf("Mac")>-1)
				bitmap = new MacBusyClass();
			else if(os.indexOf("Windows 7")>-1 || os.indexOf("Windows Vista")>-1) 
				bitmap= new WindowsAreoBusyClass();
			else if(os.indexOf("Linux")>-1)
				bitmap = new LinuxBusyClass();
			else if(os.indexOf("Windows"))
				return createBusyCursorForWindows();
				
			var bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>;
			var r:Rectangle= new Rectangle(0,0,32,32);
			var bmd:BitmapData;
			var p:Point = new Point(0, 0);
			
			
			
			var matrix:Matrix;
			var angle:int = 0;
			var angle_in_radians:Number = 0;
			for (var i:uint = 0; i < 20; i++) 
			{
				if(angle>=361)
					break;
				angle_in_radians = Math.PI * 2 * (angle / 360);
				matrix = new Matrix();
				matrix.translate(-16,-16);
				matrix.rotate(angle_in_radians);
				matrix.translate(16,16);
				bmd = new BitmapData(32, 32, true, 0x00000000);
				bmd.draw(bitmap.bitmapData, matrix, null, null, null, true);
				bitmaps.push(bmd);
				
				angle+=18;
			}
			
			
			
			var mcd:MouseCursorData = new MouseCursorData();
			mcd.data = bitmaps;
			mcd.frameRate = 24;
			return mcd;
		}
		private static function createBusyCursorForWindows():MouseCursorData{
			var bitmap:Bitmap = new WindowsBusyClass();
			
			var bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>;
			var r:Rectangle= new Rectangle(0,0,32,32);
			var bmd:BitmapData;
			var p:Point = new Point(0, 0);
			for (var i:uint = 0; i < 15; ++i)
			{
				r = new Rectangle((22 * i) , 0, 22, 22);
				bmd = new BitmapData(r.width, r.height, true, 0x000000);
				bmd.copyPixels(bitmap.bitmapData, r, p);
				bitmaps.push(bmd);
			}
			var mcd:MouseCursorData = new MouseCursorData();
			mcd.data = bitmaps;
			mcd.frameRate = 8;
			
			return mcd;
		}
		private static function degreeToRadian(deg:Number):Number
		{
			
			return deg * (Math.PI/180);
		}
	}
}