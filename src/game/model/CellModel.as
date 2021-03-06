package game.model
{
	import mvc.model.AbstractModel;
	
	public class CellModel extends AbstractModel
	{
		public static const EMPTY:int = 123;
		public static const POSSIBLE_MOVE:int = 124;
		
		public static const WHITE_STONE:int = 126;
		public static const NEW_WHITE_STONE:int = 125;
		
		public static const BLACK_STONE:int = 128;
		public static const NEW_BLACK_STONE:int = 127;
		
		private var _state:int;
		private var _row:int;
		private var _column:int;
		private var _directions:Vector.<CellModel>;
		
		public function CellModel(state:int, row:int, column:int )
		{
			super();
			
			_state = state;
			_row = row;
			_column = column;
			
			_directions = new Vector.<CellModel>();
		}

		public function get directions():Vector.<CellModel>
		{
			return _directions;
		}
		
		public function set directions(vec:Vector.<CellModel>):void 
		{
			_directions = vec;
		}

		public function haveOppoziteStones(cell:CellModel):Boolean
		{
			if (_state == BLACK_STONE && cell._state == WHITE_STONE)
				return true;
			if (_state == WHITE_STONE && cell._state == BLACK_STONE)
				return true;
			return false;
		}
		
		public function isEmpty():Boolean
		{
			return _state == EMPTY;
		}
		
		public function havePosibleMove():Boolean
		{
			return _state == POSSIBLE_MOVE;
		}
		
		public function addDirection(cell:CellModel):void
		{
			_directions[_directions.length] = cell;
		}
		
		public function removeAllDirection():void
		{
			_directions.length = 0;
		}

		public function get column():int
		{
			return _column;
		}

		public function get row():int
		{
			return _row;
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			if (value >= EMPTY && value <= BLACK_STONE)
			{
				_state = value;
			}
			if (_state == EMPTY)
			{
				_directions.length = 0;
			}
		}
		
		public function copy():CellModel
		{
			var cellCopy:CellModel = new CellModel(_state, _row,_column);
			if(_directions.length > 0)
			{
				for (var i:int = 0; i < _directions.length; ++i) 
				{
					cellCopy.addDirection(_directions[i]);
				}
			}
			return cellCopy;
		}
		
		override public function update():void{}
		override public function dispose():void
		{
			_directions = null;
			super.dispose();
		}
	}
}