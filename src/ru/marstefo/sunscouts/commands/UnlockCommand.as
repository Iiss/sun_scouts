package ru.marstefo.sunscouts.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class UnlockCommand extends AccessCodeCommand
	{
		override protected function _do():void 
		{
			scout.enabled = true;
		}
	}
}