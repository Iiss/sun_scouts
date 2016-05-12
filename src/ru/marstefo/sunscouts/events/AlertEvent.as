package ru.marstefo.sunscouts.events
{
	import flash.events.Event;
	
	public class AlertEvent extends Event
	{
		public static const ERROR:String = "error";
		
		public var reason:String;
		
		public function AlertEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new AlertEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("AlertEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}