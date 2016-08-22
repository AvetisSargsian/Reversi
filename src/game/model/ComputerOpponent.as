package game.model
{
	import game.controller.GameController;
	
	import starling.core.Starling;
	/**
	 * 
	 * @author Avetis
	 * very simple one!!! can be modificated to check more deep then the first step.
	 */
	public class ComputerOpponent
	{
		private var boardValue:Array = [
			[100, -1, 5, 2, 2, 5, -1, 100],
			[-1, -10,1, 1, 1, 1,-10, -1],
			[5 , 1,  1, 1, 1, 1,  1,  5],
			[2 , 1,  1, 0, 0, 1,  1,  2],
			[2 , 1,  1, 0, 0, 1,  1,  2],
			[5 , 1,  1, 1, 1, 1,  1,  5],
			[-1,-10, 1, 1, 1, 1,-10, -1],
			[100, -1, 5, 2, 2, 5, -1, 100]];
		
		private var gameModel:GameModel;
		private var validMoves:Vector.<CellModel>;
		private var _stone:int
		
		public function ComputerOpponent()
		{
			gameModel = GameModel.instance;
			validMoves = new Vector.<CellModel>();
			_stone = gameModel.player2Stone;
//			 
		}
		
		public function set stone(value:int):void
		{
			_stone = value;
		}

		public function get stone():int
		{
			return _stone;
		}
		
		public function makeMove():void
		{
			findCellsWithValidMoves();
			Starling.juggler.delayCall(returnCell,0.5);
		}
		
		public function dispose():void
		{
			gameModel = null;
			validMoves = null;
		}
		
		private function returnCell():void
		{
			GameController.instance.handleComputerMove(pickCell());
			validMoves.length = 0;
		}
		
		private function pickCell():CellModel
		{
			var compareValue:int = -100,
				tableValue:int,
				tempCell:CellModel,
				returnCell:CellModel;
			
			for (var i:int = 0, len:int = validMoves.length; i<len; ++i) 
			{
				tempCell = validMoves[i];
				tableValue = boardValue[tempCell.row][tempCell.column]; 
				if (tableValue > compareValue)
				{
					compareValue = tableValue;
					returnCell = validMoves[i];
				}
			}
			return returnCell;
		}
		
		private function findCellsWithValidMoves():void
		{
			var fieldSize:int = Constants.FIELD_SIZE;
			for (var i:int = 0; i < fieldSize; ++i)
			{ 
				for (var j:int = 0; j < fieldSize; ++j)
				{
					var cell:CellModel = gameModel.getCell(i,j); 
					if (cell.havePosibleMove())
					{
						validMoves.push(cell);
					}
				}
			}
		}
	}
}