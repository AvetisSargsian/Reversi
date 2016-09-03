package game.view.animator
{
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Animator
	{
		public function Animator()
		{
		}
		
		static public function flip(view:DisplayObject,time:Number,onFlipAction:Function = null,onComplete:Function = null):void
		{
//			var tween:Tween = new Tween(view,time);
//			tween.animate("scaleX",0);
//			tween.repeatCount = 2;
//			tween.reverse = true;
//			tween.onRepeat = onHalfFlipAction;
//			tween.onComplete = onComplete;
//			Starling.juggler.add(tween);
			
			var obj:Object = {
				scaleX:0,
				repeatCount:2,
				reverse:true,
				onRepeat:onFlipAction,
				onComplete:onComplete
			}
			
			Starling.juggler.tween(view,time,obj);
		}
	}
}