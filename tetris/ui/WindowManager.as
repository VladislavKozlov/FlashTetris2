package tetris.ui 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class WindowManager 
	{
		private static var _windows:Dictionary = new Dictionary();
		private static var _showedWindows:Dictionary = new Dictionary();
		private static var _cont:Sprite;
		
		public static function init(cont:Sprite):void
		{
			_cont = cont;
		}
		
		public static function show(wnd:Class, placeAtCenter:Boolean = true):void
		{
			var _currWindow:Sprite;
			var strWin: String = String(wnd);
			
			if (!_windows.hasOwnProperty(strWin))
			{
				_windows[strWin] = new wnd();
			}
				
			_currWindow = _windows[strWin];
			_cont.addChild(_currWindow);			
			_showedWindows[strWin] = _currWindow;
			
			if (placeAtCenter)
			{
				placeBackground(_currWindow);
			}
		}
		
		public static function hide(wnd:Class):void
		{
			var strWin: String = String(wnd);
			if (_showedWindows.hasOwnProperty(strWin))
			{
				var _currWindow:Sprite = _showedWindows[strWin];
				delete _showedWindows[strWin];
				_currWindow.parent.removeChild(_currWindow);
			}
		}
		
		private static function placeBackground(scaledObject:DisplayObject):void 
		{
			var stage:Stage = _cont.stage;
			scaledObject.scaleX = scaledObject.scaleY = 1;
			var scale:Number;
			if (scaledObject.width / scaledObject.height > stage.stageWidth / stage.stageHeight)
			{
				scale = stage.stageHeight / scaledObject.height;
			}
			else 
			{
				scale = stage.stageWidth / scaledObject.width;
			}
			scaledObject.scaleX = scaledObject.scaleY = scale;
			scaledObject.x = (stage.stageWidth - scaledObject.width) / 2;
			scaledObject.y = (stage.stageHeight - scaledObject.height) / 2;
		}	
	}
}