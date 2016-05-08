package ru.marstefo.sunscouts.services
{
	import flash.utils.Dictionary;
	
	public class CodeService implements ICodeService
	{
		private var _codeBase:Dictionary;
		
		public function checkCode(code:String):Boolean
		{
			if (_codeBase && _codeBase[code])
			{
				return true;
			}
			return false;
		}
		
		public function useCode(code:String):Boolean
		{
			if (checkCode(code))
			{
				delete _codeBase[code];
				return true;
			}
			return false;
		}
		
		public function configure(config:XML):void
		{
			_codeBase = new Dictionary();
			for each (var node:XML in config.children())
			{
				_codeBase[node.text().toString()] = true;
			}
		}
	}
}