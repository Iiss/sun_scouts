package ru.marstefo.sunscouts.models 
{
	public class CellModel 
	{
		public var storm:Boolean;
		public var sidesKpi:Vector.<Number>
		private var _penalty:Number = 0;
		private var _x:int;
		private var _y:int;
		public function get x():int { return _x; }
		public function get y():int { return _y; }
		public function get penalty():Number { return _penalty }
		public function set penalty(value:Number):void
		{
			_penalty = isNaN(value) ? 0 : value;
		}
		
		public function CellModel(x:int = 0, y:int = 0)
		{
			_x = x;
			_y = y;
		}
	}
}