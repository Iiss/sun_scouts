package ru.marstefo.liss.network 
{
	import flash.events.Event;
	
	public class ResultEvent extends Event 
	{
		public static const RESULT:String = "ResultEvent.RESULT"
		public var data:*;
		
		public function ResultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ResultEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ResultEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}