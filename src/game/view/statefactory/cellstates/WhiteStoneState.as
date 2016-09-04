package game.view.statefactory.cellstates
{
	import game.model.GameModel;
	import game.view.CellView;
	import animator.Animator;
	
	import starling.display.Image;

	public class WhiteStoneState extends AbstractCellState
	{
		public function WhiteStoneState()
		{
			super();
		}
		
		override public function applyToView(cellV:CellView):void
		{
			var stone:Image = cellV.getChildByName(CellView.STONE) as Image,
				time:Number = stone.color == GameModel.instance.stone1Color ? 0 : 0.25;
			cellV.getChildByName(CellView.POSIBLE_MOVE).visible = false;
			
			Animator.flip(stone,time,onFlip,invokeCallBack);
			
			function onFlip():void
			{
				stone.color = GameModel.instance.stone1Color;
				stone.visible = true;	
			}
			
		}
	}
}