package ru.marstefo.sunscouts.models 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class GameModel 
	{
		private var _colTotal:int;
		private var _rowTotal:int;
		private var _moveMask:Vector.<Boolean>;
		private var _activeMapArea:Rectangle;
		private var _mapBitmapData:BitmapData;
		private var _scouts:Vector.<SunBatteryModel>
		
		public function configure(gamedata:XML, mapImg:BitmapData):void
		{
			var mapNode:XML = gamedata.map[0]
			_colTotal = parseInt(mapNode.@col_total);
			_rowTotal = parseInt(mapNode.@row_total);
			_moveMask = new Vector.<Boolean>(_colTotal * _rowTotal, true);
			
			var cell_x:int;
			var cell_y:int;
			
			for each (var node:XML in gamedata.cells.cell)
			{
				cell_x = parseInt(node.@x);
				cell_x = parseInt(node.@y);
				_moveMask[cell_y * _colTotal + cell_x] = true;
			}
			
			var areaNode:XML = mapNode.active_area[0];
			_activeMapArea = new Rectangle();
			_activeMapArea.x = parseInt(areaNode.@x);
			_activeMapArea.y = parseInt(areaNode.@y);
			_activeMapArea.width = parseInt(areaNode.@w);
			_activeMapArea.height = parseInt(areaNode.@h);
			
			var cell_w:int = mapImg.width / _colTotal;
			var cell_h:int = mapImg.height / _rowTotal;
			var clipRect:Rectangle = new Rectangle(cell_w * _activeMapArea.x,
												   cell_h * _activeMapArea.y,
												   cell_w * _activeMapArea.width,
										           cell_h * _activeMapArea.height);
			
			_mapBitmapData = new BitmapData(clipRect.width,clipRect.height);
			_mapBitmapData.draw(mapImg, null, null, null, clipRect);
			
			_scouts = new Vector.<SunBatteryModel>();
			for each (node in gamedata.sun_scouts.scout)
			{
				_scouts.push(new SunBatteryModel(node));
			}
		}
	}
}