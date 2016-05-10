package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import flash.display.Sprite;
	import flash.events.Event;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	import ru.marstefo.sunscouts.bundles.MVCSBundleNoTraceLog;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.views.ControlViewConfig;
	import ru.marstefo.sunscouts.views.ControlViewLockState;
	import ru.marstefo.sunscouts.models.SunBatteryState;
	
	public class ControlView extends Window
	{
		private static const ERROR_STATE:String = "error";
	
		private var context:Context;
		private var _model:SunBatteryModel;
		private var _lockView:VBox;
		private var _errorView:ControlViewErrorState;
		public var operateView:ControlViewWorkingState;
		private var _moveView:Sprite;
		private var _brokenView:Sprite;
		
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
			_errorView.message = "Неверный код доступа";
			_errorView.visible = false;
			
			_lockView = new ControlViewLockState(this);
			_lockView.y = 60;
			_lockView.visible = false;
			
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
			
			setState(_model.currentState);
		}
		
		public function setState(state:String):void
		{
			_lockView.visible = (state == SunBatteryState.LOCKED);
			_moveView.visible = (state == SunBatteryState.MOVING);
			_brokenView.visible = (state == SunBatteryState.BROKEN);
			operateView.visible = (state == SunBatteryState.OPEN || 
									state == SunBatteryState.CLOSED);
			operateView.opened = (state == SunBatteryState.OPEN);
		}
	}
}