package ru.marstefo.sunscouts
{
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.sunscouts.commands.LoadAssetsCommand;
	import ru.marstefo.sunscouts.models.LocaleModel;
	import ru.marstefo.sunscouts.models.GameModel;
	import ru.marstefo.sunscouts.mediators.AppMediator;
	
	public class AppConfig implements IConfig
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
		
		public function AppConfig() 
		{
			
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(LocaleModel).asSingleton();
			injector.map(GameModel).asSingleton();
			//injector.map(LogService).asSingleton();
			//MEDIATORS
			mediatorMap.map(Main).toMediator(AppMediator);
			//event
			//eventCommandMap.map(SessionEvent.NEXT_SESSION, SessionEvent).toCommand(SetupSessionCommand);
			//Commands
			directCommandMap.map(LoadAssetsCommand).execute();
		}
		
	}

}