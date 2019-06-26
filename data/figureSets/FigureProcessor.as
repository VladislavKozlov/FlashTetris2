package data.figureSets 
{
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
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class FigureProcessor 
	{
		private static var _arrayVectors:Array = [];

		public static function getArrayVectors():Array
		{
			var figures:Array = [ FigureDataCube, FigureDataPalka, FigureDataZLeft,
									FigureDataZRight, FigureDataT, FigureDataL, FigureDataG,
									FigureDataRect, FigureDataGBig, FigureDataLBig];
			
			for each (var someData:Object in figures)
				constructFigure(someData);
			
			return _arrayVectors;
		}
		
		private static function constructFigure(rawData:Object):FigureInfo
		{
			var figureData:Object = JSON.parse(JSON.stringify(rawData));
			var result:FigureInfo = new FigureInfo()
			result.parse(figureData);
		
			var arrayVectorFigure:Array = [];
			arrayVectorFigure[0] = vectorFigureInit(result.figureLength, result.figureVector1);
			arrayVectorFigure[1] = vectorFigureInit(result.figureLength, result.figureVector2);
			arrayVectorFigure[2] = vectorFigureInit(result.figureLength, result.figureVector3);
			arrayVectorFigure[3] = vectorFigureInit(result.figureLength, result.figureVector4);
			
			_arrayVectors[result.figureType] = arrayVectorFigure;
			
			return result;
		}
		
		private static function vectorFigureInit(strLengthJSON:int, str:String):Vector.<int>
		{
			var strLength:int = str.length;
			var strItem:String;
			var vectorFigure:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < strLength; i++)
			{
				strItem = str.charAt(i);
				vectorFigure.push(strItem);
			}
			return vectorFigure;
		}
		
		public function FigureProcessor() 
		{
		}
	}
}