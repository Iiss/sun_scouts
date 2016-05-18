package ru.marstefo.sunscouts.mediators 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.sunscouts.models.GameModel;
	import ru.marstefo.sunscouts.events.GameModelEvent;
	
	public class AppMediator extends Mediator 
	{
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var view:Main;
		/// temp ///
		private var _timer:Timer
		///////////
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
			view.redrawControls(gameModel.scouts);
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, _onTimer);
		}
		
		private function _onTimer(e:TimerEvent):void
		{
			if (_timer.currentCount > gameModel.storm.time)
			{
				_timer.stop();
				gameModel.applyStorm(gameModel.storm);
			}
		}
	}
}