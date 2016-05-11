package ru.marstefo.sunscouts.mediators 
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import ru.marstefo.sunscouts.models.LocaleModel;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.views.ControlView;
	import ru.marstefo.sunscouts.events.ModelEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class ControlViewMediator extends Mediator
	{
		[Inject]
		public var model:SunBatteryModel;
		
		[Inject]
		public var view:ControlView;
		
		[Inject]
		public var locale:LocaleModel;
		
		public function ControlViewMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(model, ModelEvent.PROPERTY_CHANGED, _onModelPropChanged);
			eventMap.mapListener(view.operateView.openButton, MouseEvent.MOUSE_DOWN, _onCloseButtonClick);
			eventMap.mapListener(view.operateView.angleKnob, Event.CHANGE, _onAngleKnob);
			view.setState(model.currentState);
		}
		
		private function _onModelPropChanged(e:ModelEvent):void
		{
			switch(e.data.toString())
			{
				case "powerOut":
					view.operateView.power = model.powerOut;
					break;
				case "currentState":
					view.setState(model.currentState);
					break;
			}
		}
		
		private function _onCloseButtonClick(e:MouseEvent):void
		{
			var type:String = model.opened ? SunBatteryCommandEvent.CLOSE : SunBatteryCommandEvent.OPEN;
			dispatch(new SunBatteryCommandEvent(type));
		}
		
		private function _onAngleKnob(e:Event):void
		{
			var evt:SunBatteryCommandEvent = new SunBatteryCommandEvent(SunBatteryCommandEvent.CHANGE_ANGLE);
			evt.data = view.operateView.angleKnob.value;
			dispatch(evt);
		}
	}

}