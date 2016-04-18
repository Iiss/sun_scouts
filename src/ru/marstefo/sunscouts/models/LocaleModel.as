package ru.marstefo.sunscouts.models 
{
	import flash.utils.Dictionary;
	
	public class LocaleModel 
	{
		private var _dict:Dictionary;
		
		public function configure(localeData:XML):void
		{
			_dict = new Dictionary();
			for each (var p:XML in localeData.children())
			{
				_dict[p.name().toString()] = p.toString();
			}
		}
		
		public function getString(key:String):String
		{
			return _dict[key] as String;
		}
	}

}