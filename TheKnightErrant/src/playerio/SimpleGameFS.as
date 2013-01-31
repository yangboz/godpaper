package playerio{
	//Local GameFS implamentation
	import playerio.GameFS
	internal class SimpleGameFS implements GameFS{
		private var gameId:String
		private var wo:Object
		
		function SimpleGameFS(gameId:String, wo:Object){
			this.gameId = gameId;
			this.wo = wo;
		}
		
		public function getURL(path:String):String{
			if(path.substring(0,1) != "/"){
				throw new Error("GameFS paths must be absolute and start with a slash (/). IE PlayerIO.gameFS(\"[gameid]\").getURL(\"/folder/file.extention\")",0)
			}
			if(wo.wrapper && wo.wrapper.content && wo.wrapper.content.hasOwnProperty("getURL")){
				return wo.wrapper.content.getURL(gameId, path)
			}else{
				return "http://r.playerio.com/r/" + gameId + path;
			}
			
		}
	}	
}