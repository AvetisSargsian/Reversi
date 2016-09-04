package animator
{
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Animator
	{
		public function Animator()
		{
		}
		
		static public function flip(view:DisplayObject,time:Number,onFlipAction:Function = null,onComplete:Function = null):void
		{
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