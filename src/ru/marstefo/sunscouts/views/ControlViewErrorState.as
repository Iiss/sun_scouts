package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import com.bit101.components.Label;
	
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
			_backBtn = new PushButton(this, 0, 0, "Назад");
			message = "псс";
		}
		
		public function get backBtn():InteractiveObject { return _backBtn; }
		public function get message():String { return _errorReason.text; }
		public function set message(value:String):void { _errorReason.text = value; }
	}
}