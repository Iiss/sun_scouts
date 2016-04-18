package ru.marstefo.sunscouts.mediators 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.sunscouts.models.GameModel;
	import ru.marstefo.sunscouts.events.GameModelEvent;
	
	public class AppMediator extends Mediator 
	{
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var view:Main;
		
		public function AppMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			eventMap.mapListener(gameModel, GameModelEvent.GAME_READY, _onGameReady);
			super.initialize();
		}
		
		private function _onGameReady(e:*=null):void
		{
			view.map.bitmapData = gameModel.mapBitmapData;
		}
	}
}