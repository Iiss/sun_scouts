package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import flash.display.DisplayObjectContainer;
	import com.bit101.components.PushButton;
	import com.bit101.components.Label;
	import flash.display.InteractiveObject;
	import flash.text.TextFieldType;
	
	public class ControlViewLockState extends VBox 
	{
		private var _codeInput:Text;
		private var _submitBtn:InteractiveObject;
		private var _backBtn:InteractiveObject;
		
		public function ControlViewLockState(parent:DisplayObjectContainer) 
		{
			super(parent)
			alignment = VBox.CENTER;
			//dirty aligment hack (((
			new Label(this, 0, 0, "                                                   "); 
			//end of hack
			new Label(this,0,0,"Введите код доступа");
			_codeInput = new Text(this);
			_codeInput.height = 20;
			_codeInput.textField.multiline = false;
			_codeInput.textField.displayAsPassword = true;
			_codeInput.width = 100;
			_submitBtn = new PushButton(this, 0, 0, "Ок");
			_backBtn = new PushButton(this, 0, 0, "Отмена");
		}	
		
		public function get backBtn():InteractiveObject { return _backBtn; }
		public function get submitBtn():InteractiveObject { return _submitBtn; }
		public function get code():String { return _codeInput.text; }
		public function get cancelEnabled():Boolean { return _backBtn.visible; }
		public function set cancelEnabled(value:Boolean):void { _backBtn.visible = value; }	
	}
}