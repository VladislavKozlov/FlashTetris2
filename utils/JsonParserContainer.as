package utils 
{
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class JsonParserContainer extends JsonParserBase
	{		
		private var _priKey:String;
		public function JsonParserContainer(priKey:String) 
		{
			super();		
			_priKey = priKey;
		}
		
		protected function createDataInstance():JsonParserBase
		{
			return null;
		}
		
		override public function parse(rawData:Object):void
		{
			var rawValues:Array = (JSON.parse(rawData as String) as Array );
			var cObjData:Object;
			var cKey:String;
			var l:int = rawValues.length;
			var cDataInstance:JsonParserBase;
			
			for (var i:int = 0; i < l; i++) 
			{
				cObjData = rawValues[i];
				cKey = cObjData[_priKey];
				cDataInstance = createDataInstance();
				_values[cKey] = cDataInstance;
				cDataInstance.parse( cObjData );
			}
		}
		
		protected function getDataInstance(key:*):*
		{
			return _values[key];
		}		
	}
}