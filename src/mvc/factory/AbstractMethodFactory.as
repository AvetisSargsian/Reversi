package mvc.factory
{
	import flash.errors.IllegalOperationError;
	
	import starling.display.DisplayObjectContainer;
	
	public class AbstractMethodFactory implements IFactory
	{	
		public function AbstractMethodFactory()
		{
			super();
		}
		
		public final function produce(canvas:DisplayObjectContainer, object:Object = null):void
		{
			var prodactionLine:IStartProduct = createProduct(canvas,object);
			prodactionLine.start();
		}
		
		protected function createProduct(canvas:DisplayObjectContainer,obj:Object = null):IStartProduct
		{
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
			return null;
		}
	}
}