package ru.marstefo.sunscouts.views 
{
	import flash.events.Event;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.sunscouts.commands.LoadAssetsCommand;
	import ru.marstefo.sunscouts.mediators.ControlViewMediator;
	import ru.marstefo.sunscouts.views.ControlView;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import ru.marstefo.sunscouts.commands.OpenBatteryCommand;
	import ru.marstefo.sunscouts.commands.CloseBatteryCommand;
	import ru.marstefo.sunscouts.commands.ChangeBatteryAngleComand;
	import ru.marstefo.sunscouts.commands.ChangeBatteryAzimuthCommand;
	import ru.marstefo.sunscouts.commands.UnlockCommand;
	import ru.marstefo.sunscouts.services.AlertService;
	import ru.marstefo.sunscouts.commands.MoveBatteryCommand;
	
	public class ControlViewConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var eventCommandMap:IEventCommandMap;

		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject]
		public var contextView:ContextView;
		
		private var _model:SunBatteryModel;
		
		public function ControlViewConfig(model:SunBatteryModel) 
		{
			_model = model;
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(SunBatteryModel).toValue(_model);
			injector.map(AlertService).toValue(new AlertService());
			//MEDIATORS
			mediatorMap.map(ControlView).toMediator(ControlViewMediator);
			//event
			eventCommandMap.map(SunBatteryCommandEvent.OPEN).toCommand(OpenBatteryCommand);
			eventCommandMap.map(SunBatteryCommandEvent.CLOSE).toCommand(CloseBatteryCommand);
			eventCommandMap.map(SunBatteryCommandEvent.CHANGE_ANGLE).toCommand(ChangeBatteryAngleComand);
			eventCommandMap.map(SunBatteryCommandEvent.CHANGE_AZIMUTH).toCommand(ChangeBatteryAzimuthCommand);
			eventCommandMap.map(SunBatteryCommandEvent.UNLOCK).toCommand(UnlockCommand);
			eventCommandMap.map(SunBatteryCommandEvent.MOVE).toCommand(MoveBatteryCommand);
		}
	}
}