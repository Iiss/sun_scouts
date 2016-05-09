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
		private var _openButton:PushButton;
		
		public function ControlViewWorkingState()
		{
			_powerMeter = new Meter(this, 5, 5, "Вых. мощность")
			_powerMeter.maximum = 100;
			_statusLight = new IndicatorLight(this, 15, 116);
			_statusLight.isLit = true;
			_openButton = new PushButton(this, 105, 110);
			
			var azimuthArr:Array = ['C', 'Ю', 'З', 'В', 'СВ', 'ЮВ', 'СЗ', 'ЮЗ'];
			for (var i:int = 0; i < azimuthArr.length; i++)
			{
				new RadioButton(this, 15 + (i % 2) * 36, 150 + Math.floor(i / 2) * 22, azimuthArr[i]);
			}
			
			var _angleKnob:Knob = new Knob(this, 115, 128);
			_angleKnob.labelPrecision = 0;
			_angleKnob.radius = 40;
			_angleKnob.maximum = 90;
			
			var _moveBtn:PushButton = new PushButton(this, 5, 275, 'Переместить');
			_moveBtn.width = 200;
			_moveBtn.height = 30;
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