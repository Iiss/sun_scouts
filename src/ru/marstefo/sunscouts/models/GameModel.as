package ru.marstefo.sunscouts.models
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import ru.marstefo.sunscouts.events.GameModelEvent;
	
	public class GameModel extends EventDispatcher
	{
		private var _colTotal:int;
		private var _rowTotal:int;
		private var _moveMask:Vector.<Boolean>;
		private var _activeMapArea:Rectangle;
		private var _mapBitmapData:BitmapData;
		private var _scouts:Vector.<SunBatteryModel>
		private var _sides:Array;
		
		public function configure(gamedata:XML, mapImg:BitmapData):void
		{
			var mapNode:XML = gamedata.map[0]
			_colTotal = parseInt(mapNode.@col_total);
			_rowTotal = parseInt(mapNode.@row_total);
			_moveMask = new Vector.<Boolean>(_colTotal * _rowTotal, true);
			
			_sides = mapNode.@sides.toString().split(',');
			var numSides:int = _sides.length;
			var cell_x:int;
			var cell_y:int;
			
			for each (var node:XML in gamedata.cells.cell)
			{
				cell_x = parseInt(node.@x);
				cell_x = parseInt(node.@y);
				
				var kpiArr:Vector.<Number> = new Vector.<Number>(numSides, true);
				if (node.@sides_kpi)
				{
					var kpiSrc:Array = node.@sides_kpi.toString().split(',');
					for (var i:int = 0; i < Math.min(kpiSrc.length, numSides); i++)
					{
						kpiArr[i] = parseFloat(kpiSrc[i]);
					}
				}
				
				_moveMask[cell_y * _colTotal + cell_x] = kpiArr;
			}
			
			var areaNode:XML = mapNode.active_area[0];
			_activeMapArea = new Rectangle();
			_activeMapArea.x = parseInt(areaNode.@x);
			_activeMapArea.y = parseInt(areaNode.@y);
			_activeMapArea.width = parseInt(areaNode.@w);
			_activeMapArea.height = parseInt(areaNode.@h);
			
			var cell_w:int = mapImg.width / _colTotal;
			var cell_h:int = mapImg.height / _rowTotal;
			var dx:Number = cell_w * _activeMapArea.x;
			var dy:Number = cell_h * _activeMapArea.y;
			var clipRect:Rectangle = new Rectangle()
			clipRect.width = cell_w * _activeMapArea.width;
			clipRect.height = cell_h * _activeMapArea.height;
			
			_mapBitmapData = new BitmapData(mapImg.width, mapImg.height);
			_mapBitmapData.draw(mapImg, new Matrix(1, 0, 0, 1, -dx, -dy), null, null, clipRect);
			
			_scouts = new Vector.<SunBatteryModel>();
			for each (node in gamedata.sun_scouts.scout)
			{
				_scouts.push(new SunBatteryModel(node));
			}
			
			dispatchEvent(new GameModelEvent(GameModelEvent.GAME_READY));
		}
		
		public function get mapBitmapData():BitmapData
		{
			return _mapBitmapData
		}
		
		public function get scouts():Vector.<SunBatteryModel>
		{
			return _scouts
		}
	}
}