package 
{
	import flash.utils.getQualifiedClassName;
	
	import game.scene.GameScene;
	
	import menu.mediator.MainMenuSceneMediator;
	public class Constants 
	{
		public static const FIRST_LOAD:String  = "FIRST_LOAD";
		public static const MAIN_MENU_SCENE:String  = getQualifiedClassName(MainMenuSceneMediator);
		public static const GAME_SCENE:String       = getQualifiedClassName(GameScene);
		
		public static const STAGE_WIDTH:int  = 500;
		public static const STAGE_HEIGHT:int = 600;
		public static const FIELD_SIZE:int = 8;
		public static var CECLL_SIZE:Number = 56.7;
		
		public static function iterateThruCells(doSomeThings:Function):void
		{
			for (var i:int = 0; i < FIELD_SIZE; ++i)
			{ 
				for (var j:int = 0; j < FIELD_SIZE; ++j)
				{
					doSomeThings(i,j);
				}
			}
		}
		
	}
}