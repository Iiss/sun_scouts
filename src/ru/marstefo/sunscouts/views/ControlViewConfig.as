package ru.marstefo.sunscouts.views 
{
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import flash.events.Event;
	import ru.marstefo.sunscouts.commands.LoadAssetsCommand;
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
			//mediatorMap.map(App).toMediator(AppMediator);
			//event
			eventCommandMap.map(Event.CHANGE, Event).toCommand(LoadAssetsCommand);
			//Commands
			//directCommandMap.map(LoadAssetsCommand).execute();
		}
	}
}