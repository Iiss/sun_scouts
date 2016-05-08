package ru.marstefo.sunscouts.models 
{
	import flash.events.EventDispatcher;
	import ru.marstefo.sunscouts.events.ModelEvent;
	
	public class SunBatteryModel extends EventDispatcher
	{
		private var _id:int;
		private var _powerOut:Number;
		private var _angle:Number;
		private var _azimuth:int;
		private var _canMove:Boolean;
		private var _x:int;
		private var _y:int;
		private var _enabled:Boolean;
		private var _opened:Boolean;
		private var _sidesKpi:Vector.<int>;
		private var _currentState:String;
		private var _isBroken:Boolean;
		
		public function SunBatteryModel(scoutData:XML) 
		{
			_id = parseInt(scoutData.@id);
			_x = parseInt(scoutData.@x);
			_y = parseInt(scoutData.@y);
			_canMove = Boolean(parseInt(scoutData.@can_move));
			_enabled = Boolean(parseInt(scoutData.@enabled));
			_opened = Boolean(parseInt(scoutData.@opened));
			
			_validateState();
		}
		
		public function get powerOut():Number { return _powerOut; }
		public function get angle():Number { return _angle; }
		public function get id():int { return _id; }
		public function get azimuth():int { return _azimuth; }
		public function get canMove():Boolean { return _canMove; }
		public function get x():int { return _x; }
		public function get y():int { return _y; }
		public function get enabled():Boolean { return _enabled; }
		public function get opened():Boolean { return _opened; }
		public function get isBroken():Boolean { return _isBroken; }
		public function get currentState():String { return _currentState; }
		
		public function set enabled(value:Boolean):void
		{
			_setProperty('enabled', value);
			_validateState();
		}
		
		public function set opened(value:Boolean):void
		{
			_setProperty('opened', value);
			_validateState();
		}
		
		public function set azimuth(value:int):void
		{
			_setProperty('azimuth', value)
			_updatePower();
		}
		
		public function set angle(value:Number):void
		{
			_setProperty('angle', value)
			_updatePower();
		}
		
		public function set isBroken(value:Boolean):void
		{
			_setProperty('isBroken', value)
			_updatePower();
		}
		
		private function _updatePower():void{}
		
		private function _validateState():void
		{
			var value:String = SunBatteryState.LOCKED;
			if (enabled)
			{
				switch(true)
				{
					case isBroken: 
						value = SunBatteryState.BROKEN;
						break;
		
					default: 
						value = opened ? SunBatteryState.OPEN : SunBatteryState.CLOSED;
						break;
				}
			}
			_setProperty('currentState', value);
		}
		
		private function _setProperty(propName:String, value:*):void
		{
			if (!this['_' + propName]) return;
			if (this['_' + propName] != value)
			{
				this['_' + propName] = value;
				var e:ModelEvent = new ModelEvent(ModelEvent.PROPERTY_CHANGED);
				e.data = propName;
				dispatchEvent(e);
			}
		}
	}
}