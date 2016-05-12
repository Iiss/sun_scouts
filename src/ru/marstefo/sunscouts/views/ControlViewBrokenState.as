package ru.marstefo.sunscouts.views 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import com.bit101.components.Label;
	
	public class ControlViewBrokenState extends Sprite 
	{
		[Embed(source = "../../../../../lib/assets/broken.png")]
		private var _imgSrc:Class
		
		public function ControlViewBrokenState() 
		{
			var img:Bitmap = new _imgSrc() as Bitmap;
			addChild(img)
			var label:Label = new Label(this, 0, img.y + img.height + 10, "СЛОМАНО");
			label.x = .5 * (img.width - label.width);
		}	
	}
}