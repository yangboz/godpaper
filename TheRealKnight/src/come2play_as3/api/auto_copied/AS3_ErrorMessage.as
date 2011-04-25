package come2play_as3.api.auto_copied
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class AS3_ErrorMessage extends Sprite
	{
		private var textField:TextField;
		private var explanationField:TextField;
		private var errorReportText:String
		public function addText(text:String):void{
			if(!visible){
				visible = true
				textField.text = "";
			}
			
			if(textField == null){
				textField = new TextField();
				textField.width = stage.stageWidth-15
				textField.height = stage.stageHeight>300?200:100;
				textField.wordWrap = true
				textField.x = 10
				textField.y = 45
				textField.border = true;
				textField.text =text;
				
				explanationField = new TextField()
				explanationField.width = stage.stageWidth-30
				explanationField.height = 40;
				explanationField.wordWrap = true
				explanationField.x = explanationField.y =5
				explanationField.text = "An error occurred while loading the game. please press the button below to send an error report";
				explanationField.setTextFormat(new TextFormat("Tahoma",18));
				
				graphics.beginFill(0xF4F9EC);
				graphics.lineStyle(2,0xCB2865);
				graphics.drawRoundRect(5,5,stage.stageWidth-5,stage.stageHeight-5,3,3)
				graphics.endFill();
				var sendMessage:SimpleButton = getButton("Send Message",0x00FF00);
				var close:SimpleButton = getButton("Close",0xFF0000);
				
				sendMessage.y = close.y = stage.stageHeight - 40;
				sendMessage.x = stage.stageWidth- 150
				close.x = stage.stageWidth- 300
				sendMessage.addEventListener(MouseEvent.CLICK,sendErrorReport);
				close.addEventListener(MouseEvent.CLICK,function(ev:MouseEvent):void{visible = false});
				addChild(sendMessage);
				addChild(close);		
				
				addChild(textField);
				addChild(explanationField);
				
			}else{
				textField.appendText(text)	
			}
			errorReportText	= textField.text;
			textField.setTextFormat(new TextFormat("Tahoma",12,0x000000));		
		}
		
		private function getButton(caption:String,color:uint):SimpleButton{
			var buttonMessage:TextField = new TextField();
			buttonMessage.text = caption;
				
			var sprite:Sprite = new Sprite()
			sprite.graphics.beginFill(color);
			sprite.graphics.drawRect(0,0,120,30);
			sprite.graphics.endFill()
			sprite.addChild(buttonMessage);
				
			return new SimpleButton(sprite,sprite,sprite,sprite);
				
			
		}
		
		private function sendErrorReport(ev:MouseEvent):void{
			var mailData:URLVariables = new URLVariables();
			mailData["subject"] = "An Error in the distribution file"
			mailData["body"] = errorReportText.substr(0,2500) +"\n\n\n...................\n\n\n"+ errorReportText.substr(errorReportText.length-2500);
			navigateToURL(new URLRequest("mailto:support@come2play.com&"+mailData.toString()));
		}
	}
}