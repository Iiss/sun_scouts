package ru.marstefo.sunscouts.events 
{
	import flash.events.Event;
	
	public class ModelEvent extends Event 
	{
		public static const PROPERTY_CHANGED:String = "property_changed"
		public var data:*;
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ModelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ModelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}