package tetris 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class TetrisEvent extends Event 
	{
		public static const GAME_PLAY_GAMESCREENSTATIC            :String = "GAME_PLAY_GAMESCREENSTATIC";
		public static const APPLICATION_EXIT_GAMESCREENSTATIC     :String = "APPLICATION_EXIT_GAMESCREENSTATIC";
		public static const GAME_PLAY_GAMEOVERSCREEN    		  :String = "GAME_PLAY_GAMEOVERSCREEN";
		public static const APPLICATION_EXIT_GAMEOVERSCREEN       :String = "APPLICATION_EXIT_GAMEOVERSCREEN";
		public static const GAME_UN_PAUSE_PAUSESCREEN             :String = "GAME_UN_PAUSE_PAUSESCREEN";
		public static const GAME_PAUSE_GAMESCREEN                 :String = "GAME_PAUSE_GAMESCREEN";
		public static const GAME_EXIT_GAMESCREEN                  :String = "GAME_EXIT_GAMESCREEN";
		public static const TETRIS_CONTAINER_CREATED_GAMESCREEN	  :String = "TETRIS_CONTAINER_CREATED_GAMESCREEN";
		public static const APPLICATION_ENTRY_MAINMENU            :String = "APPLICATION_ENTRY_MAINMENU";
		public static const GAME_OVER                   		  :String = "GAME_OVER";
		public static const BUTTON_DOWN               			  :String = "BUTTON_DOWN";
		public static const FIGURE_ROTATE               		  :String = "FIGURE_ROTATE";
		public static const FIGURE_REFLECT_IN_FIELD     		  :String = "FIGURE_REFLECT_IN_FIELD";
		public static const REMOVE_FILLED_LINES         		  :String = "REMOVE_FILLED_LINES";
		public static const SCORE_UPDATED						  :String = "SCORE_UPDATED";
		public static const SOUND_ROTATE						  :String = "SOUND_ROTATE";
		public static const SOUND_REFLECT						  :String = "SOUND_REFLECT";
		public static const SOUND_REMOVE						  :String = "SOUND_REMOVE";
		public static const SOUND_GAMEOVER						  :String = "SOUND_GAMEOVER";
		public static const SOUND_BUTTONDOWN					  :String = "SOUND_BUTTONDOWN";
		
		private static var _dispatcher:EventDispatcher;
		private var _someData:*;
		
		public function get someData():*
		{
			return _someData;
		}
		
		public static function get dispatcher():EventDispatcher
		{
			if (_dispatcher == null)
			{
				_dispatcher = new EventDispatcher();
			}
				
			return _dispatcher;
		}
		
		public static function dispatch( type:String, someData:*):void
		{
			dispatcher.dispatchEvent( new TetrisEvent(type, someData ) );
		}
		
		public function TetrisEvent(type:String, obj:*=null) 
		{
			super(type, false, obj);
			_someData = obj;
		}
	}
}