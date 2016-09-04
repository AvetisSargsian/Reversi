package game.view.statefactory
{
	import game.model.CellModel;
	import game.view.statefactory.cellstates.BlackStoneState;
	import game.view.statefactory.cellstates.CellEmpyState;
	import game.view.statefactory.cellstates.CellPosibleMoveState;
	import game.view.statefactory.cellstates.ICellState;
	import game.view.statefactory.cellstates.WhiteStoneState;
	
	
	public class CellStateFactory extends AbstractMethodFactory
	{
		private var emptyState:ICellState;
		private var posibleMoveState:ICellState;
		private var whiteStoneState:ICellState;
		private var blackStoneState:ICellState;
		
		public function CellStateFactory()
		{
			super();
			
			emptyState = new CellEmpyState();
			posibleMoveState = new CellPosibleMoveState();
			whiteStoneState = new WhiteStoneState();
			blackStoneState = new BlackStoneState();
		}
		
		override protected function createProduct(type:int):ICellState
		{
			switch(type)
			{
				case CellModel.EMPTY:
				{
					return emptyState;
				}
				case CellModel.POSSIBLE_MOVE:
				{
					return posibleMoveState;
				}
				case CellModel.WHITE_STONE:
				{	
					return whiteStoneState;
				}
				case CellModel.BLACK_STONE:
				{
					return blackStoneState;
				}
			}
			return null;
		}
		
		public override function dispose():void
		{
			emptyState.dispose();
			emptyState = null;
			posibleMoveState.dispose();
			posibleMoveState = null;
			whiteStoneState.dispose();
			whiteStoneState = null;
			blackStoneState.dispose();
			blackStoneState = null;
		}
	}
}