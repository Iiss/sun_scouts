package ru.marstefo.sunscouts.commands 
{
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.sunscouts.events.SunBatteryCommandEvent;
	import ru.marstefo.sunscouts.models.SunBatteryModel;
	import ru.marstefo.sunscouts.services.AlertReason;
	import ru.marstefo.sunscouts.services.AlertService;
	import ru.marstefo.sunscouts.services.ICodeService;
	
	public class AccessCodeCommand extends Command 
	{
		[Inject]
		public var codeService:ICodeService;
		
		[Inject]
		public var cmdEvent:SunBatteryCommandEvent;
		
		[Inject]
		public var scout:SunBatteryModel;
		
		[Inject]
		public var alertService:AlertService
		
		public function AccessCodeCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			if (codeService.checkCode(cmdEvent.accessCode))
			{
				_do();
				codeService.useCode(cmdEvent.accessCode);
			}
			else
			{
				alertService.notifyError(AlertReason.CODE_ERROR);
			}
		}
		
		protected function _do():void{}
	}
}