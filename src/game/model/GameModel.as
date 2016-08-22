package game.model
{
	import mvc.model.AbstractModel;
	
	import starling.utils.Color;
	
	public class GameModel extends AbstractModel
	{
		public static const NEW_SCORE:String = "NEW_SCORE";
		public static const GAME_OVER:String = "GAME_OVER";
		public static const UPDATE_FIELD:String = "UPDATE";
		public static const SWAP_PLAYER:String = "SWAP_PLAYER";
		public static const NEW_GAME:String = "NEW_GAME";
		
		private static var _instance:GameModel;
		private const _player1Stone:int = CellModel.WHITE_STONE;
		private const _player2Stone:int= CellModel.BLACK_STONE;
		
		private var _isGameOver:Boolean;
		private var _isOpponentComputer:Boolean = false;
		private var _stone1Color:uint = Color.WHITE;
		private var _stone2Color:uint = Color.BLACK;
		private var _cellColor:uint = Color.SILVER;
		private var _cellSize:uint = 57;
		private var _player1Score:int;
		private var _player2Score:int;
		private var _nextMove:int = _player1Stone;
		private var fieldSize:int = Constants.FIELD_SIZE;
		private var fieldCells:Vector.<Vector.<CellModel>>;
		private var _posibleMoveCount:int = 0;

		public function get player2Stone():int
		{
			return _player2Stone;
		}

		public function get player1Stone():int
		{
			return _player1Stone;
		}

		public static function get instance( ):GameModel
		{
			if (_instance == null)
				_instance = new GameModel (new PrivateClass());		
			return _instance;
		}
		
		public function GameModel(pvt:PrivateClass)
		{
			super();
			createField();
		}
		
		public function get isGameOver():Boolean
		{
			return _isGameOver;
		}
		
		public function get isOpponentComputer():Boolean
		{
			return _isOpponentComputer;
		}
		
		public function set isOpponentComputer(value:Boolean):void
		{
			_isOpponentComputer = value;
		}
		
		public function get cellSize():uint
		{
			return _cellSize;
		}
		
		public function get cellColor():uint
		{
			return _cellColor;
		}
		
		public function get stone2Color():uint
		{
			return _stone2Color;
		}
		
		public function get stone1Color():uint
		{
			return _stone1Color;
		}
		
		public function get player1Score():int
		{
			return _player1Score;
		}
		
		public function get player2Score():int
		{
			return _player2Score;
		}
		
		public function get nextMove():int
		{
			return _nextMove;
		}
		
		public function get posibleMoveCount():int
		{
			return _posibleMoveCount;
		}
		
		public function set posibleMoveCount(value:int):void
		{
			_posibleMoveCount = value;
		}
		
		public function getCell(row:uint, col:uint):CellModel
		{
		 	if(row > fieldSize-1 || col > fieldSize-1) return null;	
			return fieldCells[row][col];
		}
		
		public function restartGame():void
		{
			invokeCallBacks(NEW_GAME);
			invokeCallBacks(UPDATE_FIELD);
			invokeCallBacks(NEW_SCORE);
			invokeCallBacks(SWAP_PLAYER);
		}
		
		public function havePosibleMove():Boolean
		{
			return _posibleMoveCount > 0;
		}
				
		public function nextPlayerColor():uint
		{
			return _nextMove == player1Stone ? _stone1Color : _stone2Color;
		}
		
		public function swapTurn():void
		{
			if(_nextMove == _player1Stone)
				_nextMove = _player2Stone;
			else 
				_nextMove = _player1Stone;
			invokeCallBacks(SWAP_PLAYER);
		}
		
		public function swapStoneColors():void
		{
			var tempColor:uint = _stone1Color;
			_stone1Color = _stone2Color;
			_stone1Color = tempColor;
			swapTurn();
		}
		
		public function reciveGameData(data:Object):void
		{
			_stone1Color =  data.Stone1Color;
			_stone2Color = data.Stone2Color;
			_cellColor = data.CellColor;
			_cellSize = data.CellSize;
			Constants.CECLL_SIZE = _cellSize;
		}
	
		public function updateField():void
		{
			invokeCallBacks(UPDATE_FIELD);
		}
		
		public function gameOver():void
		{
			_isGameOver = true;
			invokeCallBacks(GAME_OVER);
		}
		
		public function setScores(p1Score:int, p2Score:int):void
		{
			_player1Score = p1Score;
			_player2Score = p2Score;
			invokeCallBacks(NEW_SCORE);
		}
		
		public function initializeGame():void
		{	
			emptifyField();
			
			fieldCells[3][4].state = CellModel.BLACK_STONE;
			fieldCells[4][3].state = CellModel.BLACK_STONE;
			fieldCells[3][3].state = CellModel.WHITE_STONE;
			fieldCells[4][4].state = CellModel.WHITE_STONE;
			
//			_nextMove = _player1Stone;
			
			_player1Score = 2;
			_player2Score = 2;
			_isGameOver = false;
		}
		
		public function clearPosibleMoveMarcks():void
		{
			iterateThruCells(function(i,j):void
			{
				if (fieldCells[i][j].havePosibleMove())
					fieldCells[i][j].state = CellModel.EMPTY;
			});
			_posibleMoveCount = 0;
		}
		
		public override function dispose():void
		{	
			iterateThruCells(function(row,col):void
			{
				fieldCells[row][col].dispose();
			});
			
			fieldCells = null;
			_instance = null;
			super.dispose();
		}
		
		private function emptifyField():void
		{
			iterateThruCells(function(i,j):void
			{
				fieldCells[i][j].state = CellModel.EMPTY;
			});
		}
			
		private function iterateThruCells(doSomeThings:Function):void
		{
			for (var i:int = 0; i < fieldSize; ++i)
			{ 
				for (var j:int = 0; j < fieldSize; ++j)
				{
					doSomeThings(i,j);
				}
			}
		}
		
		private function createField():void
		{
			fieldCells = new Vector.<Vector.<CellModel>>();
			for (var row:int = 0; row < fieldSize; ++row)
			{
				fieldCells[row] = new Vector.<CellModel>();
				for (var col:int = 0; col < fieldSize; ++col)
				{
					fieldCells[row].push(new CellModel(CellModel.EMPTY,row, col));
				}
			}
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}