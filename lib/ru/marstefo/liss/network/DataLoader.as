package ru.marstefo.liss.network
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class DataLoader extends EventDispatcher
	{
		private var _loader				:URLLoader;
		private var _dataType			:String;
		
		public function DataLoader() 
		{
			_loader = new URLLoader();	
		}
		
		/**
		 * Request sender
		 *
		 */
		public function load(url:String, params:Object = null, dataFormat:String='text', method:String='GET'):void
		{
			var req:URLRequest = new URLRequest(url);
			req.method = method;
			_dataType = dataFormat;
			_loader.dataFormat = dataFormat;
			
			addListeners();
			
			if (params)
			{
				var urlVars:URLVariables = new URLVariables;
				
				for (var p:String in params)
				{
					urlVars[p] = params[p];
				}
				
				req.data = urlVars;
			}
			
			_loader.load(req);
		}
		
		/**
		 * Complete listener
		 * 
		 */
		private function _onComplete(evt:Event):void
		{
			removeListeners();
			
			var resultEvent:ResultEvent;
			
			if (_dataType == DataLoaderDataFormat.XML)
			{
				try 
				{ 
					resultEvent = new ResultEvent(ResultEvent.RESULT);
					resultEvent.data = XML(_loader.data)
					dispatchEvent(resultEvent);
				} 
				catch (e:Error)
				{
					_onError(e);
				}
			}
			else
			{
				resultEvent = new ResultEvent(ResultEvent.RESULT);
				resultEvent.data = _loader.data;
				dispatchEvent(resultEvent);
			};
			
		}
		
		/**
		 * Error listener
		 * 
		 */
		private function _onError(e:*):void
		{
			removeListeners();
			
			var faultEvent:FaultEvent = new FaultEvent(FaultEvent.ERROR);
			
			switch(true)
			{
				case e is IOErrorEvent: 		faultEvent.message = e.text; 		break; 
				case e is SecurityErrorEvent: 	faultEvent.message = e.text; 		break;
				case e is Error: 				faultEvent.message = e.message; 	break;
			}
			
			dispatchEvent(faultEvent);
		}
		
		/**
		 * Listeners management
		 * 
		 */
		private function addListeners():void
		{
			_loader.addEventListener(Event.COMPLETE, _onComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, _onError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
		}
		
		private function removeListeners():void
		{
			_loader.removeEventListener(Event.COMPLETE, _onComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, _onError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onError);
		}
	}

}