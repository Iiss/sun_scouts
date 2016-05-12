package ru.marstefo.sunscouts.services 
{
	import flash.events.EventDispatcher;
	import ru.marstefo.sunscouts.events.AlertEvent;
	
	public class AlertService extends EventDispatcher
	{
		public function notifyError(reason:String=""):void
		{
			var e:AlertEvent = new AlertEvent(AlertEvent.ERROR);
			e.reason = reason;
			dispatchEvent(e);
		}
	}
}