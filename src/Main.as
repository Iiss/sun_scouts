package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import ru.marstefo.sunscouts.views.ControlView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.bender.extensions.contextView.ContextView;
	import ru.marstefo.sunscouts.bundles.MVCSBundleNoTraceLog;
	import ru.marstefo.sunscouts.AppConfig;
	
	public class Main extends Sprite 
	{
		protected var context:IContext;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			context = Context(new Context()
			.install(MVCSBundleNoTraceLog)
			.configure(new AppConfig())
			.configure(new ContextView(this)));
			
			new ControlView(this,10,10,"Sun scout #1");
		}
		
	}
	
}