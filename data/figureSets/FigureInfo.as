package data.figureSets 
{
	//import flash.utils.ByteArray;
	//import flash.errors.EOFError;
	//import flash.utils.Endian;
	//import flash.display.Sprite;
	
	import utils.JsonParserBase;
	import data.jsonData.FigureDataCube;
	import data.jsonData.FigureDataPalka;
	import data.jsonData.FigureDataLBig;
	import data.jsonData.FigureDataZLeft;
	import data.jsonData.FigureDataG;
	import data.jsonData.FigureDataL;
	import data.jsonData.FigureDataGBig;
	import data.jsonData.FigureDataRect;
	import data.jsonData.FigureDataT;
	import data.jsonData.FigureDataZRight;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class FigureInfo extends JsonParserBase
	{
		public function get figureType():int {return _values["figureType"]; }
		public function get figureName():String {return _values["figureName"]; }
		public function get figureLength():int {return _values["figureLength"]; }
		public function get figureVector1():String {return _values["figureVector1"]; }
		public function get figureVector2():String {return _values["figureVector2"]; }
		public function get figureVector3():String {return _values["figureVector3"]; }
		public function get figureVector4():String {return _values["figureVector4"]; }
		
		public function FigureInfo() 
		{
		}
		
		override public function parse(rawData:Object):void 
		{
			super.parse(rawData);
			
			addInt("figureType", 0);
			addString("figureName", "Unknow");			
			addInt("figureLength", 0);
			addString("figureVector1", "Unknow");
			addString("figureVector2", "Unknow");
			addString("figureVector3", "Unknow");
			addString("figureVector4", "Unknow");
			
		}
	}
}