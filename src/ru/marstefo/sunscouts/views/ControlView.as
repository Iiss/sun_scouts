package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	import ru.marstefo.sunscouts.bundles.MVCSBundleNoTraceLog;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.services.AlertReason;
	import ru.marstefo.sunscouts.views.ControlViewConfig;
	import ru.marstefo.sunscouts.views.ControlViewLockState;
	import ru.marstefo.sunscouts.models.SunBatteryState;
	import ru.marstefo.sunscouts.views.AccessCodeView;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import ru.marstefo.sunscouts.events.PopUpEvent;
	
	public class ControlView extends Window
	{
		private static const ERROR_STATE:String = "error";
		private static const INPUT_CODE_STATE:String = "input_code";
		private static const INPUT_COORDINATES_STATE:String = "input_coordinates";
	
		private var context:Context;
		private var _model:SunBatteryModel;
		private var _lockView:ControlViewLockState;
		private var _errorView:ControlViewErrorState;
		public var operateView:ControlViewWorkingState;
		private var _moveView:Sprite;
		private var _brokenView:Sprite;
		private var _codeView:AccessCodeView;
		private var _currentState:String;
		private var _lastRootState:String;
		private var _coordForm:AskCoordinatesView;
		
		public function ControlView(model:SunBatteryModel)
		{
			_model = model;
			super();
			
			if (stage) initialize()
			else addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			_buildUI();
			
			// entry point
			context = Context(new Context()
			.install(MVCSBundleNoTraceLog)
			.configure(new ControlViewConfig(_model))
			.configure(new ContextView(this)));
			
			_model = null;
		}
		
		private function _buildUI():void
		{
			var pref:String = _model.canMove ? "Мобильный комплекс #" : "Стационарный комплекс #"
			title = pref + _model.id;
			
			width = 210;
			height = 330;
			
			_errorView = new ControlViewErrorState(this);
			_errorView.y = 60;
			_errorView.visible = false;
			_errorView.addEventListener(PopUpEvent.CANCEL, _onClosePopUp);
			
			_lockView = new ControlViewLockState();
			_lockView.visible = false;
			addChild(_lockView);
			
			_lockView.x = .5 * (width - _lockView.width);
			_lockView.y = .5 * (height - _lockView.height) - 20;
			_lockView.unlockBtn.addEventListener(MouseEvent.MOUSE_DOWN, _requestUnlock);
			
			operateView = new ControlViewWorkingState(_model.canMove);
			operateView.opened = _model.opened;
			operateView.power = _model.powerOut;
			operateView.visible = false;
			addChild(operateView);
			
			_moveView = new ControlViewMoveState();
			_moveView.visible = false;
			addChild(_moveView);
			
			_brokenView = new ControlViewBrokenState();
			_brokenView.visible = false;
			addChild(_brokenView);
			
			_codeView = new AccessCodeView(this)
			_codeView.y = 60;
			_codeView.visible = false;
			addChild(_codeView);
			_codeView.addEventListener(PopUpEvent.SUBMIT, _onCodeSubmit);
			_codeView.addEventListener(PopUpEvent.CANCEL, _onClosePopUp);
			
			_coordForm = new AskCoordinatesView(this);
			_coordForm.y = 60;
			_coordForm.visible = false;
			_coordForm.addEventListener(PopUpEvent.SUBMIT, _onCoordsSubmit);
			_coordForm.addEventListener(PopUpEvent.CANCEL, _onClosePopUp);
			
			currentState = _model.currentState;
		}
		
		public function get currentState():String
		{ return _currentState; }
		
		public function set currentState(state:String):void
		{
			_currentState = state;
			_lockView.visible = (state == SunBatteryState.LOCKED);
			_moveView.visible = (state == SunBatteryState.MOVING);
			_brokenView.visible = (state == SunBatteryState.BROKEN);
			operateView.visible = (state == SunBatteryState.OPEN || 
									state == SunBatteryState.CLOSED);
			operateView.opened = (state == SunBatteryState.OPEN);
			_codeView.visible = (state == INPUT_CODE_STATE);
			_errorView.visible = (state == ERROR_STATE);
			_coordForm.visible = (state == INPUT_COORDINATES_STATE);
			
			if (state != INPUT_CODE_STATE && 
				state != ERROR_STATE && 
				state != INPUT_COORDINATES_STATE)
			{
				_lastRootState = state;
			}
		}
		
		public function showAccessPopUp(eventType:String,data:*=null):void
		{ 
			_codeView.clear();
			_codeView.enabled = true;
			_codeView.commandEventType = eventType;
			_codeView.transferData = data;
			currentState = INPUT_CODE_STATE;
		}
		
		public function showError(alertReason:String):void
		{
			switch (alertReason)
			{
				case AlertReason.CODE_ERROR:
					_errorView.message = "Неверный код";
					break;
			}
			currentState = ERROR_STATE;
		}
		
		public function askNewPosition():void
		{
			_coordForm.clear();
			_coordForm.enabled = true;
			currentState = INPUT_COORDINATES_STATE;
		}
		
		public function destroy():void
		{
			_codeView.destroy();
			_errorView.destroy();
			_coordForm.destroy();
		}
		
		private function _onCodeSubmit(e:*=null):void
		{
			var evt:SunBatteryCommandEvent = new SunBatteryCommandEvent(_codeView.commandEventType);
			evt.data = _codeView.transferData 
			evt.accessCode = _codeView.code;
			dispatchEvent(evt);
			_codeView.enabled = false;
		}
		
		private function _onCoordsSubmit(e:*= null):void
		{
			var evt:SunBatteryCommandEvent = new SunBatteryCommandEvent(SunBatteryCommandEvent.MOVE);
			evt.accessCode = _coordForm.code;
			evt.data = { position:_coordForm.position };
			dispatchEvent(evt);
			_coordForm.enabled = false;
		}
		
		private function _onClosePopUp(e:*=null):void
		{ 
			currentState = _lastRootState;
		}
		
		private function _requestUnlock(e:MouseEvent):void
		{
			showAccessPopUp(SunBatteryCommandEvent.UNLOCK);
		}
	}
}