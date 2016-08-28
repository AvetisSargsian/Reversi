package game.controller
{
	import flash.utils.Dictionary;
	
	import game.model.CellModel;
	import game.model.GameModel;
	
	import starling.core.Starling;

	public class ComputerOpponent
	{		
		private var boardValue:Array = [
			[500, 1, 10, 4, 4, 10, 1, 500],
			[1 , 0, 2, 2, 2, 2, 0, 1],
			[10, 2, 2, 2, 2, 2, 2, 10],
			[4 , 2, 2, 0, 0, 2, 2, 4],
			[4 , 2, 2, 0, 0, 2, 2, 4],
			[10, 2, 2, 2, 2, 2, 2, 10],
			[1 , 0, 2, 2, 2, 2, 0, 1],
			[500, 1, 10, 4, 4, 10, 1, 500]];
		
		private var gameModel:GameModel;
		private var _stone:int
		private var _depth:int = 2;
		private var moveCell:CellModel;
		
		public function ComputerOpponent()
		{
			gameModel = GameModel.instance;
			_stone = gameModel.player2Stone;
		}
		
		public function get depth():int
		{
			return _depth;
		}

		public function set depth(value:int):void
		{
			_depth = value;
		}

		public function set stone(value:int):void
		{
			_stone = value;
		}

		public function get stone():int
		{
			return _stone;
		}
		
		public function dispose():void
		{
			gameModel = null;
			moveCell = null;
		}
		
		public function makeMove():void
		{
			var validMoves:Vector.<CellModel> = findCellsWithValidMoves(gameModel),
				allValues:Dictionary = new Dictionary(),
				length:int = validMoves.length,
				cell:CellModel,
				value:int;
			
			for (var i:int = 0; i < length; ++i) 
			{
				cell = validMoves[i];		
				value = calculateDepth(cell, gameModel, _depth-1);
				allValues[value] = cell;
				value = 0;
			}
			
			var tempValue:int = -10000000;
			for (var v:int in allValues) 
			{
				if (v > tempValue)
					tempValue = v;
			}
			
			moveCell = allValues[tempValue];
			Starling.juggler.delayCall(returnCell,0.5);
		}
		
		private function calculateDepth(cell:CellModel, gm:GameModel,dep:int):int
		{
			var value:int = boardValue[cell.row][cell.column];
			if (dep <= 0) return value;
			gm = gm.createCopy(gm.createFieldCopy());
			GameController.instance.swapStonesOnField(gm.getCell(cell.row,cell.column),gm);
			gm.swapTurn();
			GameController.instance.setPosibleMovesMarcks(gm);
			
			var validMoves:Vector.<CellModel> = findCellsWithValidMoves(gm),
				length:int = validMoves.length,
				returnValue:int = -1000000,
				nextVal:int;
			
			for (var i:int = 0; i < length && dep > 0; ++i) 
			{
				nextVal = calculateDepth(validMoves[i], gm, dep-1);
				if (nextVal > returnValue)
					returnValue = nextVal;	
			}
			if (dep % 2 == 0)
				value += returnValue;
			else
				value -= returnValue;
			return value;
		}
		
		private function returnCell():void
		{
			GameController.instance.handleComputerMove(moveCell);
		}
		
		private function findCellsWithValidMoves(gameModel:GameModel):Vector.<CellModel>
		{
			var validMoves:Vector.<CellModel> = new Vector.<CellModel>(),
				fieldSize:int = Constants.FIELD_SIZE;
			Constants.iterateThruCells(function(i,j):void
			{
				var cell:CellModel = gameModel.getCell(i,j); 
				if (cell.havePosibleMove())
				{
					validMoves.push(cell);
				}
			});
			return validMoves;
		}
	}
}