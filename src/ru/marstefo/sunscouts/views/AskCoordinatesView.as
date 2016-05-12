package ru.marstefo.sunscouts.views
{
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import ru.marstefo.sunscouts.events.PopUpEvent;
	
	public class AskCoordinatesView extends VBox
	{
		private var _codeInput:Text;
		private var _submitBtn:InteractiveObject;
		private var _backBtn:InteractiveObject;
		public var commandEventType:String;
		public var transferData:*;
		private var _xInput:Text;
		private var _yInput:Text;
		private var _position:Point;
		
		public function AskCoordinatesView(parent:DisplayObjectContainer)
		{
			super(parent)
			alignment = VBox.CENTER;
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			//dirty aligment hack (((
			new Label(this, 0, 0, "                                                   ");
			//end of hack
			new Label(this, 0, 0, "Введите код доступа");
			new Label(this, 0, 0, "и координаты");
			_codeInput = new Text(this);
			_codeInput.height = 20;
			_codeInput.textField.multiline = false;
			_codeInput.textField.displayAsPassword = true;
			_codeInput.textField.setTextFormat(tf);
			_codeInput.textField.defaultTextFormat = tf;
			_codeInput.width = 100;
			var hBox:HBox = new HBox(this);
			_xInput = new Text(hBox);
			new Label(hBox, 0, 0, ":");
			_yInput = new Text(hBox);
			_xInput.textField.restrict = _yInput.textField.restrict = "0-9";
			_xInput.width = _yInput.width = 42;
			_xInput.height = _yInput.height = _codeInput.height;
			_xInput.textField.multiline = _yInput.textField.multiline = false;
			_xInput.textField.maxChars = _yInput.textField.maxChars = 2;
			_xInput.textField.setTextFormat(tf);
			_xInput.textField.defaultTextFormat = tf;
			_yInput.textField.setTextFormat(tf);
			_yInput.textField.defaultTextFormat = tf;
			
			_submitBtn = new PushButton(this, 0, 0, "Ок");
			_backBtn = new PushButton(this, 0, 0, "Отмена");
			
			_position = new Point();
			
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}
		
		public function clear():void
		{
			_codeInput.text = "";
			_xInput.text = "";
			_yInput.text = "";
		}
		
		public function get code():String
		{
			return _codeInput.text;
		}
		
		public function get position():Point
		{
			var newX:int = parseInt(_xInput.text);
			var newY:int = parseInt(_yInput.text);
			
			_position.x = isNaN(newX) ? 0 : newX;
			_position.y = isNaN(newY) ? 0 : newY;
			
			return _position;
		}
		
		public function destroy():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			_backBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onCancel);
			removeEventListener(KeyboardEvent.KEY_DOWN, _onCodeInputKey);
			_submitBtn.removeEventListener(MouseEvent.MOUSE_DOWN, _onCodeSubmit);
		}
		
		private function _onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			_backBtn.addEventListener(MouseEvent.MOUSE_DOWN, _onCancel);
			addEventListener(KeyboardEvent.KEY_DOWN, _onCodeInputKey);
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