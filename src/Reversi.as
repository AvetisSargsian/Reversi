package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DProfile;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Rectangle;
	
	import navigation.StarlingRootDisplayObject;
	
	import starling.core.Starling;

	[SWF(backgroundColor="#000",frameRate="60")]
	public class Reversi extends Sprite
	{
		private var myStarling:Starling;
		
		public function Reversi()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageWidth = Constants.STAGE_WIDTH;
			stage.stageHeight = Constants.STAGE_HEIGHT;
			
			if(this.stage) this.init();
			else this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (event:*):void {	myStarling.start() });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (event:*):void { myStarling.stop() });
			
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZING, 
				function(event:NativeWindowBoundsEvent):void { event.preventDefault()});
		}
		
		private function init(event:flash.events.Event = null):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.init);

			var viewPort:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			myStarling = new Starling(StarlingRootDisplayObject, stage, viewPort,
							null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE);
			myStarling.stage.stageWidth  = Constants.STAGE_WIDTH;
			myStarling.stage.stageHeight = Constants.STAGE_HEIGHT;
 
			myStarling.supportHighResolutions = true;
			myStarling.skipUnchangedFrames = true;
			viewPort = null;
			myStarling.showStats = true;
			myStarling.antiAliasing = 1;
			myStarling.start();
		}
	}
}