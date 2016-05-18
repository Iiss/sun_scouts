package ru.marstefo.sunscouts.models 
{
	import flash.geom.Point;
	public class StormModel 
	{
		private var _time:int
		private var _cells:Array;
		
		public function setup(xml:XML):void
		{
			_time = parseInt(xml.@time);
			_cells = new Array();
			
			var pt_x:int;
			var pt_y:int;
			var pt:Point;
			
			for each (var node:XML in xml.cell)
			{
				pt_x = parseInt(node.@x);
				pt_y = parseInt(node.@y);
				pt = new Point();
				pt.x = isNaN(pt_x) ? 0 : pt_x;
				pt.y = isNaN(pt_y) ? 0 : pt_y;
				_cells.push(pt);
			}
		}
		
		public function get time():int
		{
			return _time;
		}
		
		public function get cells():Array
		{
			return _cells;
		}
	}
}