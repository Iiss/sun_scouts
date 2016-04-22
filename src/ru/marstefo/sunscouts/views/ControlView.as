package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Knob;
	import com.bit101.components.Label;
	import com.bit101.components.Meter;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.ProgressBar;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.RotarySelector;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import ru.marstefo.sunscouts.bundles.MVCSBundleNoTraceLog;
	import ru.marstefo.sunscouts.models.LocaleModel;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.views.ControlViewConfig;
	
	public class ControlView extends Window
	{
		private static const ON_COLOR:uint = 0x00ff00;
		private static const OFF_COLOR:uint = 0xff0000;
		
		private var _powerMeter:Meter;
		private var context:Context;
		private var _model:SunBatteryModel;
		private var _statusLight:IndicatorLight;
		private var _openButton:PushButton;
		
		public function ControlView(model:SunBatteryModel)
		{
			_model = model;
			super();
			
			if (stage) initialize()
			else addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			// entry point
			context = Context(new Context()
			.install(MVCSBundleNoTraceLog)
			.configure(new ControlViewConfig(_model))
			.configure(new ContextView(this)));
			
			_buildUI();
			_model = null;
		}
		
		private function _buildUI():void
		{
			var pref:String = _model.canMove ? "Мобильный комплекс #" : "Стационарный комплекс #"
			title = pref + _model.id;
			
			width = 210;
			height = 330;
			_powerMeter = new Meter(this, 5, 5, "Вых. мощность")
			_powerMeter.maximum = 100;
			_statusLight = new IndicatorLight(this, 15, 116);
			_statusLight.isLit = true;
			_openButton = new PushButton(this, 105, 110);
			setOpened(_model.opened);
			setPower(_model.powerOut);

			
			var azimuthArr:Array = ['C', 'Ю', 'З', 'В', 'СВ', 'ЮВ', 'СЗ', 'ЮЗ'];
			for (var i:int = 0; i < azimuthArr.length; i++)
			{
				new RadioButton(this, 15+(i%2)*36, 150 + Math.floor(i / 2) * 22, azimuthArr[i]);
			}
			
			
			
			var _angleKnob:Knob = new Knob(this, 115, 128);
			_angleKnob.labelPrecision = 0;
			_angleKnob.radius = 40;
			_angleKnob.maximum = 90;
			
			var _moveBtn:PushButton = new PushButton(this, 5, 275, 'Переместить');
			_moveBtn.width = 200;
			_moveBtn.height = 30;
			
			new Label(this, 10, 250, "Состояние");
			var _durabilityBar:ProgressBar = new ProgressBar(this, 105, 255);
			_durabilityBar.maximum = 100;
			_durabilityBar.value = Math.random()*100;
		}
		
		public function setOpened(value:Boolean):void
		{
			if (value)
			{
				_statusLight.color = ON_COLOR;
				_statusLight.label = "Открыты";
				_openButton.label = "Закрыть";
			}
			else
			{
				_statusLight.color = OFF_COLOR;
				_statusLight.label = "Закрыты";
				_openButton.label = "Открыть";
			}
		}
		
		public function setPower(value:Number):void
		{
			_powerMeter.value = value;
		}
	}
}