package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ru.marstefo.sunscouts.events.PopUpEvent;
	
	public class ControlViewErrorState extends VBox 
	{
		private var _backBtn:InteractiveObject;
		private var _errorReason:Label;
		
		public function ControlViewErrorState(parent:DisplayObjectContainer) 
		{
			super(parent);
			alignment = VBox.CENTER;
			//dirty aligment hack (((
			new Label(this, 0, 0, "                                                   "); 
			//end of hack
			var errorTitle:Label = new Label(this,0,0,"Ошибка");
			_errorReason = new Label(this);
			new Label(this, 0, 0, "                                                   "); 
			_backBtn = new PushButton(this, 0, 20, "Назад");
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			_backBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onCancel);
		}
		
		public function get message():String { return _errorReason.text; }
		public function set message(value:String):void { _errorReason.text = value; }
		
		private function _onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			_backBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onCancel);
		}
		
		private function _onCancel(e:* = null):void
		{
			dispatchEvent(new PopUpEvent(PopUpEvent.CANCEL));
		}
	}
}