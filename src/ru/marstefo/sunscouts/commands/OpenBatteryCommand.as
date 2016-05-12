package ru.marstefo.sunscouts.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class OpenBatteryCommand extends Command
	{
		[Inject]
		public var scout:SunBatteryModel;
		
		public function OpenBatteryCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if (scout.currentCell && scout.currentCell.storm)
			{
				scout.isBroken = true;
			}
			else
			{
				scout.opened = true;
			}
			super.execute();
		}
	}
}