package ru.marstefo.sunscouts.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class PopUpEvent extends Event 
	{
		public static const SUBMIT:String = "submit";
		public static const CANCEL:String = "cancel";
		
		public function PopUpEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new PopUpEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PopUpEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}