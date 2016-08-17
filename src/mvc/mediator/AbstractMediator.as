package mvc.mediator
{
	import mvc.view.AbstractView;

	public class AbstractMediator implements IMediator
	{
		private var _contextView:AbstractView;
		private var _nativeVIew:AbstractView;
		
		public function AbstractMediator(thisView:AbstractView = null) 
		{
			if (thisView)
				_nativeVIew = thisView;
			else
				_nativeVIew = setNativeVIew();
		}
		
		public function dispose():void
		{
			_contextView.removeChild(_nativeVIew);
			_nativeVIew.dispose();
			_contextView = null;
			_nativeVIew = null;
		}
		
		public final function get nativeVIew():AbstractView	{ return _nativeVIew; }
		public final function get contextView():AbstractView {	return _contextView; }
		
		public final function addToParent(parent:AbstractView):void
		{
			if (_nativeVIew && parent && !_contextView)
			{
				_contextView = parent;
				_contextView.addChild(_nativeVIew);
			}
		}
		
		protected function setNativeVIew():AbstractView
		{
			return new AbstractView();
		}
	}
}