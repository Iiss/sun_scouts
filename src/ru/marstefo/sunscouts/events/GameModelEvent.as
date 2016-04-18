package ru.marstefo.sunscouts.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class GameModelEvent extends Event 
	{
		public static const GAME_READY:String = "gameReady";
		
		public function GameModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new GameModelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameModelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}