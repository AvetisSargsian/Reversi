package mvc.factory
{
	import starling.display.DisplayObjectContainer;

	public interface IFactory
	{
		function produce(canvas:DisplayObjectContainer, object:Object = null):void
	}
}