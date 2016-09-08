package game.view.statefactory.cellstates
{
	import game.model.GameModel;
	import game.view.CellView;
	import animator.Animator;
	
	import starling.display.Image;

	public class WhiteStoneState extends AbstractCellState
	{		
		override public function applyToView(cellV:CellView):void
		{
			var stone:Image = cellV.getChildByName(CellView.STONE) as Image,
				time:Number;
			cellV.getChildByName(CellView.POSIBLE_MOVE).visible = false;
			
			if (stone.visible)
			{
				time = stone.color == GameModel.instance.stone1Color ? 0 : 0.25;
				function onFlip():void	{
					stone.color = GameModel.instance.stone1Color;	
				}
				Animator.flip(stone,time,onFlip,invokeCallBack);
			}else
			{
				time = 0.55;
				stone.color = GameModel.instance.stone1Color;
				stone.visible = true;
				stone.scale = 1.5;
				
				Animator.drop(stone,time,invokeCallBack);
			}
		}
	}
}