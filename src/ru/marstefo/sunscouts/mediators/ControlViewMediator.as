package ru.marstefo.sunscouts.mediators 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.sunscouts.models.LocaleModel;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.views.ControlView;
	
	public class ControlViewMediator extends Mediator
	{
		[Inject]
		public var model:SunBatteryModel;
		
		[Inject]
		public var view:ControlView;
		
		[Inject]
		public var locale:LocaleModel;
		
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