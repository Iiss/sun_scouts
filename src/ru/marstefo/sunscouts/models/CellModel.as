package ru.marstefo.sunscouts.models 
{
	public class CellModel 
	{
		public var sidesKpi:Vector.<Number>
		private var _penalty:Number = 0;
		
		public function get penalty():Number { return _penalty }
		public function set penalty(value:Number):void
		{
			if (isNaN(value)) value = 0;
		}
	}
}