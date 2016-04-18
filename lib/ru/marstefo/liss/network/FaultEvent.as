package ru.marstefo.liss.network 
{
	import flash.events.Event;
	
	public class FaultEvent extends Event 
	{
		public static const ERROR:String = "FaultEvent.ERROR";
		public var message:String;
		
		public function FaultEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);	
		} 
		
		public override function clone():Event 
		{ 
			return new FaultEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FaultEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}