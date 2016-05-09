package ru.marstefo.sunscouts.commands 
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	
	public class ChangeBatteryAzimuthCommand extends Command
	{
		[Inject]
		public var scout:SunBatteryModel;
		
		[Inject]
		public var cmdEvent:SunBatteryCommandEvent;
		
		public function ChangeBatteryAzimuthCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			scout.azimuth = cmdEvent.data;
			super.execute();
		}
	}
}