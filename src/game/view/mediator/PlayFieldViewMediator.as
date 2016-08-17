package game.view.mediator
{
	import game.controller.GameController;
	import game.model.CellModel;
	import game.model.GameModel;
	import game.view.CellView;
	import game.view.PlayFieldView;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class PlayFieldViewMediator extends AbstractMediator
	{
		private var gameModel:GameModel;
		
		public function PlayFieldViewMediator(thisView:AbstractView=null)
		{
			super(thisView);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage)
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
			
			gameModel = GameModel.instance;
			gameModel.registerCallBack(GameModel.UPDATE_FIELD,updateCells);
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);

//			ToDO:implement with builder pattern ....
			var fieldSize:int = Constants.FIELD_SIZE,
				cellSize:int = gameModel.cellSize,
				cell:CellView,
				_x:int = 0,
				_y:int = 0;
			
			nativeVIew.x = (Constants.STAGE_WIDTH - cellSize * Constants.FIELD_SIZE)/2;
			nativeVIew.y = 3;
			
			for (var i:int = 0; i < fieldSize; i++) 
			{
				for (var j:int = 0; j < fieldSize; j++) 
				{
					cell = new CellView();
					cell.name = i.toString() + j.toString(); 
					cell.x = _x;
					cell.y = _y;
					nativeVIew.addChild(cell);
					
					var bg:Image = cell.getChildByName(CellView.CELL_BG) as Image;
					bg.setVertexColor(0, gameModel.cellColor);
					bg.setVertexColor(2, gameModel.cellColor);
					bg.setVertexColor(3, gameModel.cellColor);
					
					setCellState(cell,gameModel.getCell(i,j));
					_x += cellSize;
				}
				_x = 0;
				_y += cellSize;
			}
		}
		
		private function updateCells(event:Event = null):void
		{
			var cell:CellView,
				length:int = Constants.FIELD_SIZE;
			
			for (var i:int = 0; i < length; ++i) 
			{
				for (var j:int = 0; j < length; ++j) 
				{
					cell = nativeVIew.getChildByName(i.toString() + j.toString()) as CellView;
					if (cell)
						setCellState(cell,gameModel.getCell(i,j));
				}	
			}
		}
		
		private function setCellState(cellView:CellView, cellModel:CellModel):void
		{
//			ToDo:implement with pattern State;get state from fabric
			var stone:Image;
			switch(cellModel.state)
			{
				case CellModel.EMPTY:
				{
					cellView.getChildByName(CellView.STONE).visible = false;
					cellView.getChildByName(CellView.POSIBLE_MOVE).visible = false;
					break;
				}
				case CellModel.POSSIBLE_MOVE:
				{
					cellView.getChildByName(CellView.STONE).visible = false;
					cellView.getChildByName(CellView.POSIBLE_MOVE).visible = true;
					break;
				}
				case CellModel.WHITE_STONE:
				{	
					stone = cellView.getChildByName(CellView.STONE) as Image;
					stone.color = gameModel.stone1Color;
					stone.visible = true;
					cellView.getChildByName(CellView.POSIBLE_MOVE).visible = false;
					break;
				}
				case CellModel.BLACK_STONE:
				{
					stone = cellView.getChildByName(CellView.STONE) as Image;
					stone.color = gameModel.stone2Color;
					stone.visible = true;
					cellView.getChildByName(CellView.POSIBLE_MOVE).visible = false;
					break;
				}
			}
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(nativeVIew,TouchPhase.BEGAN);
			if(touch)
			{
				GameController.instance.handleFieldTouch(touch);
			}
		}
		
		override public function dispose():void
		{
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
			gameModel.removeCallBack(GameModel.UPDATE_FIELD,updateCells);
			gameModel = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new PlayFieldView();
		}
		
	}
}