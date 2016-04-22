package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import ru.marstefo.sunscouts.views.ControlView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.bender.extensions.contextView.ContextView;
	import ru.marstefo.sunscouts.bundles.MVCSBundleNoTraceLog;
	import ru.marstefo.sunscouts.AppConfig;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import flash.display.StageScaleMode;
	
	public class Main extends Sprite 
	{
		protected var context:IContext;
		public var map:Bitmap;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			context = Context(new Context()
			.install(MVCSBundleNoTraceLog)
			.configure(new AppConfig())
			.configure(new ContextView(this)));
			
			map = new Bitmap();
			addChild(map);
		}
		
		public function redrawControls(source:Vector.<SunBatteryModel>):void
		{
			for (var i:int = numChildren - 1; i >= 0; i--)
			{
				if (getChildAt(i) as ControlView) removeChildAt(i);
			}
			
			var cv:ControlView;
			var gap:int = 5;
			var columns:int = 2;
			
			for (i = 0; i < source.length; i++)
			{
				cv = new ControlView(source[i]);
				addChild(cv);
				cv.x = (i % columns) * (cv.width + gap);
				cv.y = Math.floor(i / columns) * (cv.height + gap);
			}
		}
	}
}