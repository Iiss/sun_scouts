package ru.marstefo.sunscouts.services
{
	public interface ICodeService
	{
		function checkCode(code:String):Boolean;
		function useCode(code:String):Boolean;
		function configure(config:XML):void;
	}
}