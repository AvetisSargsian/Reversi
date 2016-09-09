package game.view.mediators
{
	import game.controller.GameController;
	import game.model.CellModel;
	import game.model.GameModel;
	import game.view.CellView;
	import game.view.statefactory.CellStateFactory;
	
	import mvc.factory.IFactory;
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class PlayFieldViewMediator extends AbstractMediator
	{
		private var cellCount:int = Constants.FIELD_SIZE * Constants.FIELD_SIZE;
		private var gameModel:GameModel;
		private var stateFactory:IFactory;
		private var touchEnabled:Boolean = true;
		
		public function PlayFieldViewMediator(thisView:AbstractView=null)
		{
			super(thisView);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage)
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
			
			gameModel = GameModel.instance;
			gameModel.registerCallBack(GameModel.UPDATE_FIELD,updateCells);
			
			stateFactory = new CellStateFactory();
		}
		
		override public function dispose():void
		{
			nativeVIew.addEventListener(TouchEvent.TOUCH,onTouch);
			gameModel.removeCallBack(GameModel.UPDATE_FIELD,updateCells);
			gameModel = null;
			stateFactory.dispose();
			stateFactory = null;
			super.dispose();
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);

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
			touchEnabled = false;
			Constants.iterateThruCells(function(i,j):void
			{
				cell = nativeVIew.getChildByName(i.toString() + j.toString()) as CellView;
				if (cell)
					setCellState(cell,gameModel.getCell(i,j));
			});
		}
		
		private function setCellState(cellView:CellView, cellModel:CellModel):void
		{
			stateFactory.produce(cellView, {"type":cellModel.state, "callBack":touchEnebler});
		}
		
		private function touchEnebler():void
		{
			-- cellCount ;
			if (cellCount <= 0)
			{	
				touchEnabled = true;
				cellCount = Constants.FIELD_SIZE * Constants.FIELD_SIZE;
			}
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(nativeVIew,TouchPhase.BEGAN);
			if(touch && touchEnabled)
			{
				GameController.instance.handleFieldTouch(touch);
			}
		}
	}
}