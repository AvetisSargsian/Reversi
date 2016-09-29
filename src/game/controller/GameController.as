package game.controller
{
	import game.model.CellModel;
	import game.model.GameModel;
	import game.view.CellView;
	
	import mvc.controller.AbstractController;
	import mvc.view.BaseView;
	
	import starling.events.Touch;
	
	public class GameController extends AbstractController
	{
		private static var _instance:GameController;
		private var gameModel:GameModel;
		private var compOpponent:ComputerOpponent;
		private var isTouchEnabled:Boolean = true;
		
		public function GameController(pvt:PrivateClass)
		{
			super();
			gameModel = GameModel.instance;
			compOpponent = new ComputerOpponent();
		}
		
		public static function get instance( ):GameController
		{
			if (_instance == null)
				_instance = new GameController (new PrivateClass());		
			return _instance;
		}
		
		public function passDtat(data:Object):void
		{
			gameModel.reciveGameData(data);
		}
		
		public function restartGame():void
		{
			gameModel.initializeGame()
			setPosibleMovesMarcks(gameModel);
			gameModel.restartGame();
			
			computerMove();
		}
		
		public function compOppSwitcher(value:Boolean):void
		{
			gameModel.isOpponentComputer = value;
		}
		
		override public function dispose():void
		{
			gameModel = null;
		}
		
		public function handleFieldTouch(touch:Touch):void
		{
			var cellView:BaseView = touch.target.parent as CellView;
			if (cellView && isTouchEnabled)
			{
				var row:int = Math.ceil(cellView.y/gameModel.cellSize),
					col:int = Math.ceil(cellView.x/gameModel.cellSize);
				var cellM:CellModel = gameModel.getCell(row,col);
				if (cellM && cellM.havePosibleMove())
					makeMove(cellM);
			}
		}
		
		public function swapStoneColors():void
		{
			gameModel.swapStoneColors();
			compOpponent.stone = gameModel.nextMove == gameModel.player1Stone ? gameModel.player2Stone : gameModel.player1Stone;
		}
		
		internal function swapStonesOnField(cellM:CellModel,gm:GameModel):void
		{
			var dir:Vector.<CellModel> = cellM.directions,
				cell:CellModel;
			while((cell = dir.pop())!= null)
			{
				var startRow:int = cell.row,
					startCol:int = cell.column,
					vertLength:int = cellM.row - startRow,
					gorizLength:int = cellM.column - startCol,
					stepVert:int = vertLength != 0 ? vertLength/Math.abs(vertLength) : 0,
					stepGoriz:int = gorizLength !=0 ? gorizLength/Math.abs(gorizLength) : 0,
					nextCell:CellModel
				
				while(true)
				{
					startRow += stepVert; startCol += stepGoriz;
					nextCell = gm.getCell(startRow, startCol);
					if(nextCell) nextCell.state = gm.nextMove;
					if(nextCell.row == cellM.row && nextCell.column == cellM.column) break; 
				}
			}
		}
		
		internal function handleComputerMove(cellM:CellModel):void
		{
			if (cellM)
				makeMove(cellM);
			isTouchEnabled = true;
		}
		
		internal function setPosibleMovesMarcks(gm:GameModel):void
		{
			gm.clearPosibleMoveMarcks();
			Constants.iterateThruCells(function(row,col):void
			{
				var cell:CellModel = gm.getCell(row,col); 
				if(cell.state == gm.nextMove)
					checkForValidMoves(cell,gm);
			});
		}
		
		private function countScores(gm:GameModel):void
		{
			var player1Score:int = 0,
				player2Score:int = 0;
			
			Constants.iterateThruCells(function(i,j):void 
			{
				if (gm.getCell(i,j).state == CellModel.WHITE_STONE)
					player1Score++;
				else if(gm.getCell(i,j).state == CellModel.BLACK_STONE)
					player2Score++;
			});
			gm.setScores(player1Score,player2Score);
		}
		
		private function makeMove(cellM:CellModel):void
		{
			swapStonesOnField(cellM,gameModel);
			countScores(gameModel);
			var count:int = 2;
			do{
				count--;
				gameModel.swapTurn();
				setPosibleMovesMarcks(gameModel);
				if(count < 0)
				{
					isTouchEnabled = true;
					gameModel.gameOver();
					break;
				}
			}while(!gameModel.havePosibleMove());
			
			gameModel.updateField();
			
			computerMove();
		}
		
		private function computerMove():void
		{
			if (gameModel.isOpponentComputer && !gameModel.isGameOver && compOpponent.stone == gameModel.nextMove)
			{
				isTouchEnabled = false;
				compOpponent.makeMove();
			}	
		}
		
		private function checkForValidMoves(cell:CellModel,gm:GameModel):void
		{
			var up:int = -1,
				down:int = 1,
				left:int = -1,
				right:int = 1,
				noMove:int = 0;
			
			direction(cell,gm,down,noMove);
			direction(cell,gm,down,right);
			direction(cell,gm,down,left);
			direction(cell,gm,noMove,left);
			direction(cell,gm,noMove,right);
			direction(cell,gm,up,left);
			direction(cell,gm,up,noMove);
			direction(cell,gm,up,right);
		}
		
		private function direction(cell:CellModel,gm:GameModel,verticalStep:int,gorizontalStep:int):void
		{			
			var	haveOppozite:Boolean,
				nextCell:CellModel,
				startPosRow:int = cell.row + verticalStep, 
				startPosCol:int = cell.column + gorizontalStep,
				startPosRowHolder:int = startPosRow,
				startPosColHolder:int = startPosCol;
			
			while(true)
			{
				nextCell = gm.getCell(startPosRow,startPosCol)
				if (!nextCell)return;
				
				haveOppozite = cell.haveOppoziteStones(nextCell);
				if (startPosRow == startPosRowHolder && startPosColHolder == startPosCol && !haveOppozite)
					return;
				startPosRow += verticalStep;
				startPosCol += gorizontalStep;
				if (haveOppozite)
					continue;
				if (nextCell.isEmpty() || nextCell.havePosibleMove())
				{
					nextCell.state = CellModel.POSSIBLE_MOVE;
					nextCell.addDirection(cell);
					gm.posibleMoveCount++;
					return; 
				}
				return;
			}
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}