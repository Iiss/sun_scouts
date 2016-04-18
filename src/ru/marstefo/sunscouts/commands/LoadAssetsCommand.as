package ru.marstefo.sunscouts.commands 
{
	import br.com.stimuli.loading.BulkLoader;
	import robotlegs.bender.bundles.mvcs.Command;
	import ru.marstefo.liss.network.DataLoader;
	import ru.marstefo.liss.network.ResultEvent;
	import ru.marstefo.liss.network.FaultEvent;
	import ru.marstefo.liss.network.DataLoaderDataFormat;
	import br.com.stimuli.loading.BulkProgressEvent;
	import ru.marstefo.sunscouts.models.GameModel;
	import ru.marstefo.sunscouts.models.LocaleModel;
	
	public class LoadAssetsCommand extends Command 
	{
		private static const GAMEDATA_URL:String = "data/gamedata.xml";
		private static const LOCALE_URL:String = "data/locale.xml";
		private static const MAP_URL:String = "data/geo_map.jpg";
		
		private var _dataLoader:BulkLoader;
		
		[Inject]
		public var localeModel:LocaleModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function LoadAssetsCommand() 
		{
			_dataLoader = new BulkLoader("data_loader");
		}
		
		override public function execute():void 
		{
			_dataLoader.add(GAMEDATA_URL, { id:"gamedata", type:BulkLoader.TYPE_XML } );
			_dataLoader.add(LOCALE_URL, { id:"locale", type:BulkLoader.TYPE_XML } );
			_dataLoader.add(MAP_URL, { id:"map", type:BulkLoader.TYPE_IMAGE } );
			_dataLoader.addEventListener(BulkProgressEvent.COMPLETE, _onResult);
			_dataLoader.addEventListener(BulkLoader.ERROR, _onError);
			
			_dataLoader.start();
			super.execute();
		}
		
		private function _onResult(e:BulkProgressEvent):void
		{ 
			localeModel.configure(_dataLoader.getXML("locale", true));
			gameModel.configure(_dataLoader.getXML("gamedata", true), 
								_dataLoader.getBitmapData("map", true));
			_dataLoader.clear();
		}
		
		private function _onError(e:*):void
		{ 
			_removeListeners();
			trace(e.text); 
		}
		
		private function _removeListeners():void
		{
			_dataLoader.removeEventListener(BulkProgressEvent.COMPLETE, _onResult);
			_dataLoader.removeEventListener(BulkLoader.ERROR, _onError);
		}
	}
}