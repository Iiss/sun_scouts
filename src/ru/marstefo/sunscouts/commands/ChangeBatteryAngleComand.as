package ru.marstefo.sunscouts.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class ChangeBatteryAngleComand extends Command
	{
		[Inject]
		public var scoutModel:SunBatteryModel;
		
		[Inject]
		public var cmdEvent:SunBatteryCommandEvent;
		
		public function ChangeBatteryAngleComand()
		{
			super();
		}
		
		override public function execute():void
		{
			scoutModel.angle = cmdEvent.data;
			super.execute();
		}
	}
}