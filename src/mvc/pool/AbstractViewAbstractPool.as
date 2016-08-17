package mvc.pool
{
	import mvc.view.AbstractView;
	
	import starling.events.Event;

	public class AbstractViewAbstractPool
	{
		private var poolVec:Vector.<AbstractView>
		
		public function AbstractViewAbstractPool()
		{
			poolVec = new Vector.<AbstractView>();
		}
		
		public function fillUp(count:int):void
		{
			for (var i:int = 0; i < count; ++i) 
			{
				poolVec.push(createView());
			}
		}
		
		public function take():AbstractView
		{
			var view:AbstractView;
			if (poolVec.length > 0)
			{
				view = poolVec.pop();
			}else
			{
				view = createView();
			}
			view.addEventListener(Event.REMOVED_FROM_STAGE, returnToPool);
			return view;
		}
		
		public function put(view:AbstractView):void
		{
			poolVec.push(view);
		}
		
		public function flush():void
		{
			for (var i:int = 0,len:int = poolVec.length; i < len; ++i) 
			{
				poolVec[i].dispose();
				poolVec[i] = null;
			}
			poolVec.length = 0;
		}
		
		public function dispose():void
		{
			poolVec = null;
		}
		
		protected function createView():AbstractView
		{
			return new AbstractView(); 
		}
		
		private function returnToPool(event:Event):void
		{
			var veiw:AbstractView = event.target as AbstractView;
			veiw.removeEventListener(Event.REMOVED_FROM_STAGE, returnToPool);
			put(veiw);
		}
	}
}