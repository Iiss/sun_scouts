package ru.marstefo.sunscouts.views 
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class ControlViewLockState extends Sprite 
	{
		[Embed(source = "../../../../../lib/assets/locked.png")]
		private var _imgSrc:Class;
		
		public var unlockBtn:PushButton;
	
		public function ControlViewLockState() 
		{
			var img:Bitmap = new _imgSrc() as Bitmap;
			addChild(img);
			
			unlockBtn = new PushButton(this, 0, img.y+img.height+10, "Разблокировать");
		}		
	}
}