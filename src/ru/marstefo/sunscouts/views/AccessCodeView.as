package ru.marstefo.sunscouts.views
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import ru.marstefo.sunscouts.events.PopUpEvent;
	
	public class AccessCodeView extends VBox
	{
		private var _codeInput:Text;
		private var _submitBtn:InteractiveObject;
		private var _backBtn:InteractiveObject;
		public var commandEventType:String;
		public var transferData:*;
		
		public function AccessCodeView(parent:DisplayObjectContainer)
		{
			super(parent)
			alignment = VBox.CENTER;
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			//dirty aligment hack (((
			new Label(this, 0, 0, "                                                   ");
			//end of hack
			new Label(this, 0, 0, "Введите код доступа");
			_codeInput = new Text(this);
			_codeInput.height = 20;
			_codeInput.textField.multiline = false;
			_codeInput.textField.displayAsPassword = true;
			_codeInput.textField.setTextFormat(tf);
			_codeInput.textField.defaultTextFormat = tf;
			_codeInput.width = 100;
			_submitBtn = new PushButton(this, 0, 0, "Ок");
			_backBtn = new PushButton(this, 0, 0, "Отмена");
			
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		public function clear():void
		{
			_codeInput.text = "";
		}
		
		public function get code():String
		{
			return _codeInput.text;
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			_backBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onCancel);
			_codeInput.removeEventListener(KeyboardEvent.KEY_DOWN, _onCodeInputKey);
			_submitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onCodeSubmit);
		}
		
		private function _onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			_backBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onCancel);
			_codeInput.addEventListener(KeyboardEvent.KEY_DOWN, _onCodeInputKey);
			_submitBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onCodeSubmit);
		}
		
		private function _onCodeInputKey(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.ENTER)
			{
				_onCodeSubmit();
			}
			else if (e.keyCode == Keyboard.ESCAPE)
			{
				_onCancel();
			}
		}
		
		private function _onCodeSubmit(e:* = null):void
		{
			dispatchEvent(new PopUpEvent(PopUpEvent.SUBMIT));
		}
		
		private function _onCancel(e:* = null):void
		{
			dispatchEvent(new PopUpEvent(PopUpEvent.CANCEL));
		}
		
		override public function get visible():Boolean
		{
			return super.visible;
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			if (value && stage)
			{
				stage.focus = _codeInput.textField;
			}
		}
	}
}