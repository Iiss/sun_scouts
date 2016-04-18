package ru.marstefo.sunscouts.models 
{
	public class SunBatteryModel 
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
		
		public function SunBatteryModel(scoutData:XML) 
		{
			_id = parseInt(scoutData.@id);
			_x = parseInt(scoutData.@x);
			_y = parseInt(scoutData.@y);
			_canMove = Boolean(parseInt(scoutData.@can_move));
			_enabled = Boolean(parseInt(scoutData.@enabled));
			_opened = Boolean(parseInt(scoutData.@opened));
			
			/// temp data ///
			_powerOut = Math.floor(Math.random() * 100);
			_angle = Math.floor(Math.random() * 90);
			_azimuth = Math.floor(Math.random() * 8);
		}
		
		public function get powerOut():Number { return _powerOut; }
		public function get angle():Number { return _angle; }
		public function get azimuth():int { return _azimuth; }
		public function get canMove():Boolean { return _canMove; }
		public function get x():int { return _x; }
		public function get y():int { return _y; }
		public function get enabled():Boolean { return _enabled; }
		public function get opened():Boolean { return _opened; }
	}
}