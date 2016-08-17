package mvc.mediator
{
	import mvc.disposeble.IDisposeble;
	import mvc.view.AbstractView;

	public interface IMediator extends IDisposeble
	{
		function get nativeVIew():AbstractView;
		function get contextView():AbstractView;
		function addToParent(parent:AbstractView):void
	}
}