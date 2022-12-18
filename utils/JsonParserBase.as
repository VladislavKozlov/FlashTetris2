package utils 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class JsonParserBase
	{
		protected var _values:Object = {};
		protected var _wasSetted:Object = {};
		
		private var _rawData:Object;
		
		public function JsonParserBase() 
		{			
		}
		
		public function parse(rawData:Object):void
		{
			_rawData = rawData;
		}
		
		protected function endLoad():void
		{
			_rawData = null;
		}
		
		protected function addInt(prop:String, defVal:int = 0):void 
		{
			if (_rawData[prop] && _rawData[prop] is int)
			{
				_values[prop] = _rawData[prop];
				_wasSetted[prop] = true;
			}
			else
			{
				_values[prop] = defVal;
				_wasSetted[prop] = false;
			}
		}
		
		protected function addNumber(prop:String, defVal:Number = 0):void 
		{
			if (_rawData[prop] && _rawData[prop] is Number)
			{
				_values[prop] = _rawData[prop];
				_wasSetted[prop] = true;
			}
			else
			{
				_values[prop] = defVal;
				_wasSetted[prop] = false;
			}
		}
		
		protected function addBool(prop:String, defVal:Boolean = false):void 
		{
			if (_rawData[prop] && _rawData[prop] is Boolean)
			{
				_values[prop] = _rawData[prop];
				_wasSetted[prop] = true;
			}
			else
			{
				_values[prop] = defVal;
				_wasSetted[prop] = false;
			}
		}
		
		protected function addString(prop:String, defVal:String = null):void 
		{
			if (_rawData[prop] && _rawData[prop] is String)
			{
				_values[prop] = _rawData[prop];
				_wasSetted[prop] = true;
			}
			else
			{
				_values[prop] = defVal;
				_wasSetted[prop] = false;
			}
		}
		
		protected function addPoint(prop:String, needDefault:Boolean = false, defX:Number = 0, defY:Number = 0):void 
		{
			var t:Array = _rawData[prop] as Array;
			if (_rawData[prop] && t != null && t.length == 2)
			{
				
				_values[prop] = new Point(t[0], t[1]);
				_wasSetted[prop] = true;
			}
			else
			{
				if(needDefault)
					_values[prop] = new Point( defX, defY);
				_wasSetted[prop] = false;
			}
		}
		
		protected function addRect(prop:String, needDefault:Boolean = false, defX:Number = 0, defY:Number = 0, defW:Number = 0, defH:Number = 0):void 
		{
			var t:Array = _rawData[prop] as Array;
			if (_rawData[prop] && t != null && t.length == 4)
			{
				
				_values[prop] = new Rectangle(t[0], t[1], t[2], t[3]);
				_wasSetted[prop] = true;
			}
			else
			{
				if(needDefault)
					_values[prop] = new Rectangle(defX, defY, defW,defH);
				_wasSetted[prop] = false;
			}
		}
		
		protected function addArray(prop:String, defVal:Array = null):void 
		{
			if (_rawData[prop] && _rawData[prop] is Array)
			{
				
				_values[prop] = _rawData[prop];
				_wasSetted[prop] = true;
			}
			else
			{
				_values[prop] = defVal;
				_wasSetted[prop] = false;
			}
		}
	}
}