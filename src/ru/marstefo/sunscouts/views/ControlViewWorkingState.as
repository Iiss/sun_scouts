package ru.marstefo.sunscouts.views
{
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Knob;
	import com.bit101.components.Meter;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import flash.display.Sprite;
	
	public class ControlViewWorkingState extends Sprite
	{
		private static const ON_COLOR:uint = 0x00ff00;
		private static const OFF_COLOR:uint = 0xff0000;
		
		private var _powerMeter:Meter;
		private var _statusLight:IndicatorLight;
		public var openButton:PushButton;
		public var angleKnob:Knob;
		public var moveButton:PushButton;
		
		public function ControlViewWorkingState(isMobile:Boolean=false)
		{
			_powerMeter = new Meter(this, 5, 5, "Вых. мощность")
			_powerMeter.maximum = 100;
			_statusLight = new IndicatorLight(this, 15, 116);
			_statusLight.isLit = true;
			openButton = new PushButton(this, 105, 110);
			
			var azimuthArr:Array = ['C', 'Ю', 'З', 'В', 'СВ', 'ЮВ', 'СЗ', 'ЮЗ'];
			for (var i:int = 0; i < azimuthArr.length; i++)
			{
				new RadioButton(this, 15 + (i % 2) * 36, 150 + Math.floor(i / 2) * 22, azimuthArr[i]);
			}
			
			angleKnob = new Knob(this, 115, 128);
			angleKnob.labelPrecision = 0;
			angleKnob.radius = 40;
			angleKnob.maximum = 90;
			
			if (isMobile)
			{
				moveButton = new PushButton(this, 5, 275, 'Переместить');
				moveButton.width = 200;
				moveButton.height = 30;
			}
		}
		
		public function get opened():Boolean
		{
			return _statusLight.color == ON_COLOR;
		}
		
		public function set opened(value:Boolean):void
		{
			if (value)
			{
				_statusLight.color = ON_COLOR;
				_statusLight.label = "Открыты";
				openButton.label = "Закрыть";
			}
			else
			{
				_statusLight.color = OFF_COLOR;
				_statusLight.label = "Закрыты";
				openButton.label = "Открыть";
			}
		}
		
		public function get power():Number
		{
			return _powerMeter.value;
		}
		
		public function set power(value:Number):void
		{
			_powerMeter.value = value;
		}
	}
}