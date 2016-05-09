package ru.marstefo.sunscouts.events 
{
	import flash.events.Event;
	
	public class SunBatteryCommandEvent extends Event 
	{
		public static const OPEN:String = "open";
		public static const CLOSE:String = "close";
		public static const MOVE:String = "move";
		public static const UNLOCK:String = "unlock";
		public static const CHANGE_ANGLE:String = "change_angle";
		public static const CHANGE_AZIMUTH:String = "change_azimuth";
		
		public var accessCode:String;
		public var data:*;
		
		public function SunBatteryCommandEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);		
		} 
		
		public override function clone():Event 
		{ 
			return new SunBatteryCommandEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SunBatteryCommandEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}