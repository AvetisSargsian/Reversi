package game.view.statefactory
{
	import flash.errors.IllegalOperationError;
	
	import game.view.CellView;
	
	import mvc.view.AbstractView;
	import mvc.factory.IFactory;
	import game.view.statefactory.cellstates.ICellState;
	
	public class AbstractMethodFactory implements IFactory
	{	
		public function AbstractMethodFactory()
		{
			super();
		}
		
		public function dispose():void {}
		
		
		public final function produce(cellV:AbstractView, type:int):void
		{
			var cellState:ICellState = createProduct(type);
			if (cellState)
				cellState.applyToView(cellV as CellView);
		}
		
		protected function createProduct(type:int):ICellState
		{
			throw new IllegalOperationError("Abstract method: must be overridden in a subclass");
			return null;
		}
	}
}