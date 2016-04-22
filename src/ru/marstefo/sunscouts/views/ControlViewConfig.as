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
			//MEDIATORS
			mediatorMap.map(ControlView).toMediator(ControlViewMediator);
			//event
			//eventCommandMap.map(Event.CHANGE, Event).toCommand(LoadAssetsCommand);
			//Commands
			//directCommandMap.map(LoadAssetsCommand).execute();
		}
	}
}