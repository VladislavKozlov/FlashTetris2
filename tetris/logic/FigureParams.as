package  tetris.logic
{
	import data.figureSets.FigureProcessor;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class FigureParams 
	{
		private static var _typeFigure:int;
		private static var _angleFigure:int;
		private static var _arrayVectorFigures:Array = [];
		
		public static function createFigures():Array
		{
			_arrayVectorFigures = FigureProcessor.getArrayVectors();
			return _arrayVectorFigures;
		}
		
		public static function createType():int
		{
			_typeFigure = int(Math.random() * _arrayVectorFigures.length);
			return _typeFigure;
		}
		
		public static function createAngle():int
		{
			_angleFigure = int(Math.random() * 4);
			return _angleFigure;
		}
		
		public function FigureParams() 
		{	
		}
	}
}