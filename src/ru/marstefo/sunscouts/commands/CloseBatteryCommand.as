package ru.marstefo.sunscouts.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class CloseBatteryCommand extends Command
	{
		[Inject]
		public var scout:SunBatteryModel;
		
		public function CloseBatteryCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			scout.opened = false;
		}
	}
}