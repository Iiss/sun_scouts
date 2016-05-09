package ru.marstefo.sunscouts.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class UnlockCommand extends Command
	{
		[Inject]
		public var scout:SunBatteryModel;
		
		public function UnlockCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			scout.enabled = true;
			super.execute();
		}
	}
}