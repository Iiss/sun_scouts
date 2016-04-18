package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Label;
	import com.bit101.components.Meter;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import ru.marstefo.sunscouts.bundles.MVCSBundleNoTraceLog;
	import ru.marstefo.sunscouts.views.ControlViewConfig;
	
	public class ControlView extends Window
	{
		private static const ON_COLOR:uint = 0x00ff00;
		private static const OFF_COLOR:uint = 0xff0000;
		
		private var _powerMeter:Meter;
		protected var context:IContext;
		
		public function ControlView(parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, title:String = "")
		{
			super(parent, x, y, title);
			
			if (stage) initialize();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			context = Context(new Context()
			.install(MVCSBundleNoTraceLog)
			.configure(new ControlViewConfig())
			.configure(new ContextView(this)));
			
			_buildUI();
		}
		
		private function _buildUI():void
		{
			width = 270;
			height = 400;
			_powerMeter = new Meter(this, 5, 5, "Вых. мощность")
			_powerMeter.maximum = 100;
			
			new IndicatorLight(this, 15, 116, OFF_COLOR, "Открыты");
			new PushButton(this, 105, 110, "Открыть");
			/*var _slider:VUISlider = new VUISlider(this, 210, 0, "a");
			_slider.tick = 1;
			_slider.labelPrecision = 0;
			_slider.maximum = 90;
			_slider.width = 30;
			_slider.height = 200;*/
			new Label(this, 15, 135, "Zenith angle");
			var _stepper:NumericStepper = new NumericStepper(this, 125, 135);
			_stepper.minimum = 0;
			_stepper.maximum = 90;
			
			var azimuthArr:Array = ['N', 'E', 'S', 'W', 'NE', 'NW', 'SE', 'SW'];
			for (var i:int = 0; i < azimuthArr.length; i++)
			{
				new RadioButton(this, 5, 140 + i * 20, azimuthArr[i]);
			}
		}
	}
}