package ru.marstefo.sunscouts.mediators
{
	import com.bit101.components.RadioButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.IInjector;
	import ru.marstefo.sunscouts.events.ModelEvent;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import ru.marstefo.sunscouts.models.LocaleModel;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.services.AlertService;
	import ru.marstefo.sunscouts.views.ControlView;
	import ru.marstefo.sunscouts.events.AlertEvent;
	
	public class ControlViewMediator extends Mediator
	{
		[Inject]
		public var model:SunBatteryModel;
		
		[Inject]
		public var view:ControlView;
		
		[Inject]
		public var locale:LocaleModel;
		
		[Inject]
		public var alertService:AlertService;
		
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
			eventMap.mapListener(view.operateView, MouseEvent.CLICK, _onOperateViewClick);
			if (model.canMove)
			{
				eventMap.mapListener(view.operateView.moveButton, MouseEvent.MOUSE_DOWN, _onMoveBtnClick);
			}
			eventMap.mapListener(view, SunBatteryCommandEvent.UNLOCK, _onUnlockRequest);
			eventMap.mapListener(view, SunBatteryCommandEvent.MOVE, _onMoveRequest);
			eventMap.mapListener(alertService, AlertEvent.ERROR, _onError);
			view.currentState = model.currentState;
			view.operateView.azimuth = model.azimuth;
			view.operateView.updatePositionInfo(model.currentCell);
		}
		
		private function _onModelPropChanged(e:ModelEvent):void
		{
			switch (e.data.toString())
			{
				case "currentCell":
					view.operateView.updatePositionInfo(model.currentCell);
					view.currentState = model.currentState;
					break;
				case "powerOut": 
					view.operateView.power = model.powerOut;
					break;
				case "currentState": 
					view.currentState = model.currentState;
					break;
			}
		}
		
		private function _onError(e:AlertEvent):void
		{
			view.showError(e.reason);
		}
		
		private function _onCloseButtonClick(e:MouseEvent):void
		{
			var type:String = model.opened ? SunBatteryCommandEvent.CLOSE : SunBatteryCommandEvent.OPEN;
			_dispatchCommandEvent(type);
		}
		
		private function _onAngleKnob(e:Event):void
		{
			_dispatchCommandEvent(SunBatteryCommandEvent.CHANGE_ANGLE, view.operateView.angleKnob.value);
		}
		
		private function _onOperateViewClick(e:MouseEvent):void
		{
			var rb:RadioButton = e.target as RadioButton;
			if (rb)
			{
				_dispatchCommandEvent(SunBatteryCommandEvent.CHANGE_AZIMUTH, view.operateView.azimuth);
			}
		}
		
		private function _onUnlockRequest(e:SunBatteryCommandEvent):void
		{
			_dispatchCommandEvent(SunBatteryCommandEvent.UNLOCK, null,e.accessCode);
		}
		
		private function _onMoveRequest(e:SunBatteryCommandEvent):void
		{
			_dispatchCommandEvent(SunBatteryCommandEvent.MOVE, e.data,e.accessCode);
		}
		
		private function _onMoveBtnClick(e:MouseEvent):void
		{
			view.askNewPosition();
		}
		
		private function _dispatchCommandEvent(type:String, data:* = null,accessCode:String = null):void
		{
			var evt:SunBatteryCommandEvent = new SunBatteryCommandEvent(type);
			evt.data = data;
			evt.accessCode = accessCode;
			dispatch(evt);
		}
	}
}