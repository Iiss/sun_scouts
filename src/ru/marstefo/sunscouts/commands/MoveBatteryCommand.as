package ru.marstefo.sunscouts.commands 
{
	import flash.geom.Point;
	import ru.marstefo.sunscouts.models.CellModel;
	import ru.marstefo.sunscouts.models.GameModel;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class MoveBatteryCommand extends AccessCodeCommand
	{		
		[Inject]
		public var gameModel:GameModel
		
		override protected function _do():void 
		{
			var pt:Point = cmdEvent.data.position;
			
			for each(var sm:SunBatteryModel in gameModel.scouts)
			{
				if ((sm!=scout) &&(sm.x == pt.x) && (sm.y == pt.y))
				{
					alertService.notifyError();
					return;
				}
			}
			var cell:CellModel = gameModel.getCell(cmdEvent.data.position);
			if (cell)
			{
				scout.currentCell = cell;
				scout.opened = false;
			}
			else
			{
				alertService.notifyError();
			}
		}
	}
}