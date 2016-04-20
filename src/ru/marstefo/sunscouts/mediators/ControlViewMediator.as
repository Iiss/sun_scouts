package ru.marstefo.sunscouts.mediators 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	
	public class ControlViewMediator extends Mediator
	{
		[Inject]
		public var model:SunBatteryModel;
		
		[Inject]
		public var view:Main;
		
		public function ControlViewMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
		}
	}

}