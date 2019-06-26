package data.figureSets 
{
	import utils.JsonParserBase;
	import utils.JsonParserContainer;
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class FigureInfoConatiner extends JsonParserContainer
	{
		public function FigureInfoConatiner() 
		{
			super("id")
		}
		
		override protected function createDataInstance():JsonParserBase 
		{
			return new FigureInfo();
		}
		
		public function getDataById(key:int):FigureInfo
		{
			return getDataInstance(key);
		}
	}
}