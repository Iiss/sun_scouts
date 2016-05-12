package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import flash.display.DisplayObjectContainer;
	
	public class ControlViewLockState extends VBox 
	{
		public var unlockBtn:PushButton;
	
		public function ControlViewLockState(parent:DisplayObjectContainer) 
		{
			super(parent)
			unlockBtn = new PushButton(this, 0, 0, "Разблокировать");
		}		
	}
}