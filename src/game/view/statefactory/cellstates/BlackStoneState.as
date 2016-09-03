package game.view.statefactory.cellstates
{
	import game.model.GameModel;
	import game.view.CellView;
	import game.view.animator.Animator;
	
	import starling.display.Image;

	public class BlackStoneState extends AbstractCellState
	{
		public function BlackStoneState()
		{
			super();
		}
		
		override public function applyToView(cellV:CellView):void
		{
			var stone:Image = cellV.getChildByName(CellView.STONE) as Image,
				time:Number = stone.color == GameModel.instance.stone2Color ? 0 : 0.25;
			
			Animator.flip(stone,time,onFlip,invokeCallBack);
			
			function onFlip():void
			{
				stone.color = GameModel.instance.stone2Color;
				stone.visible = true;
				cellV.getChildByName(CellView.POSIBLE_MOVE).visible = false;
			}
		}
	}
}