package assets
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * DefaultEmbededAssets.as class.For obtainning static embeded resources.
	 * @see http://livedocs.adobe.com/flex/3/html/help.html?content=embed_3.html 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Aug 12, 2011 10:32:59 AM
	 */   	 
	public class DefaultEmbededAssets
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//tollgate icon class here
		[Embed(source="/assets/images/icons/tollgate01_50x50.png")]
		public static const ICON_TOLLGATE_01:Class;
		
		[Embed(source="/assets/images/icons/tollgate02_50x50.png")]
		public static const ICON_TOLLGATE_02:Class;
		
		[Embed(source="/assets/images/icons/tollgate03_50x50.png")]
		public static const ICON_TOLLGATE_03:Class;
		
		[Embed(source="/assets/images/icons/tollgate04_50x50.png")]
		public static const ICON_TOLLGATE_04:Class;
		
		[Embed(source="/assets/images/icons/tollgate04_50x50.png")]
		public static const ICON_TOLLGATE_05:Class;
		
		//plugin category icon class here.
		[Embed(source="/assets/images/icons/store_50x50.png")]
		public static const ICON_STORE:Class;
		
		[Embed(source="/assets/images/icons/coin_50x50.png")]
		public static const ICON_COIN:Class;
		
		[Embed(source="/assets/images/icons/account_50x50.png")]
		public static const ICON_ACCOUNT:Class;
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
		public function DefaultEmbededAssets()
		{
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
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