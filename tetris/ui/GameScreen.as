package tetris.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import tetris.visual.UIButton;
	import tetris.Assets;
	import tetris.TetrisEvent;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class GameScreen extends Sprite 
	{
		private var _gameScreenDynamicContainer:DisplayObjectContainer;
		private var _background:Bitmap;
		private var _gameLogo:Bitmap;
		public var tetrisContainer:DisplayObjectContainer;
		private var _buttonQuit:UIButton;
		private var _buttonPause:UIButton;
		private var _scoreTextField:TextField;
		private var _linesTextField:TextField;
		private var _levelTextField:TextField;
		
		public function GameScreen() 
		{
			tetrisContainer = new Sprite();
			addEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
		}
		
		private function onAdddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
			_gameScreenDynamicContainer = new Sprite();
			addChild(_gameScreenDynamicContainer);
			
			_background = new Bitmap();
			_background = Assets.backgroundGeneral;
			_background.smoothing = true;
			_gameScreenDynamicContainer.addChild(_background);
			
			_background.x = (_gameScreenDynamicContainer.width - _background.width) / 2;
			_background.y = (_gameScreenDynamicContainer.height - _background.height) / 2;
		
			_gameScreenDynamicContainer.addChild(tetrisContainer);
			_background = new Bitmap();
			_background = Assets.backgroundTetris;
			_background.smoothing = true;
			tetrisContainer.addChild(_background);
			
			tetrisContainer.x = (_gameScreenDynamicContainer.width - tetrisContainer.width) / 2;
			tetrisContainer.y = (_gameScreenDynamicContainer.height - tetrisContainer.height) / 2;
			
			_levelTextField = createTextField(tetrisContainer.x + 220, tetrisContainer.y + 120, TextFieldAutoSize.LEFT, TextFormatAlign.LEFT);
			_linesTextField = createTextField(tetrisContainer.x + 220, tetrisContainer.y + 150, TextFieldAutoSize.LEFT, TextFormatAlign.LEFT);
			_scoreTextField = createTextField(tetrisContainer.x + 220, tetrisContainer.y + 180, TextFieldAutoSize.LEFT, TextFormatAlign.LEFT);
			
			_gameLogo = new Bitmap();
			_gameLogo = Assets.logoBitmap;
			_gameLogo.x = tetrisContainer.x + 200;
			_gameLogo.y = tetrisContainer.y + 349;
			_gameScreenDynamicContainer.addChild(_gameLogo);
			
			var buttonPauseBp:Bitmap = new Bitmap();
			buttonPauseBp = Assets.buttonPause;

			_buttonPause = new UIButton(null, buttonPauseBp);
			_buttonPause.x = tetrisContainer.x + 220;
			_buttonPause.y = tetrisContainer.y + 250;
			_gameScreenDynamicContainer.addChild(_buttonPause);
			_buttonPause.addEventListener(MouseEvent.CLICK, onPauseClick);
			
			var buttonQuitBp:Bitmap = new Bitmap();
			buttonQuitBp = Assets.buttonQuit;
			
			_buttonQuit = new UIButton(null, buttonQuitBp);
			_buttonQuit.x = tetrisContainer.x + 220;
			_buttonQuit.y = tetrisContainer.y + 300;
			_gameScreenDynamicContainer.addChild(_buttonQuit);
			_buttonQuit.addEventListener(MouseEvent.CLICK, onQuitClick);
			
			TetrisEvent.dispatcher.addEventListener(TetrisEvent.SCORE_UPDATED, onScoreUpdated);
			TetrisEvent.dispatch(TetrisEvent.TETRIS_CONTAINER_CREATED_GAMESCREEN, tetrisContainer);
		}
		
		private function createTextField(x:int, y:int, autoSize:String, align:String):TextField
		{
			var tf:TextField = new TextField();
			tf.type = TextFieldType.DYNAMIC;
			tf.selectable = false;
			tf.x = x;
			tf.y = y;
			tf.autoSize = autoSize;
			
			var format:TextFormat = tf.defaultTextFormat;
			format.align = align;
			format.size = 16;
			format.bold = true;
			format.color = 0x000000;
			tf.defaultTextFormat = format;
			addChild(tf);
			
			return tf;
		}
		
		private function onScoreUpdated(event:TetrisEvent):void
		{
			_scoreTextField.text = "Score: " + event.someData.score;
			_linesTextField.text = "Lines: " + event.someData.lines;
			_levelTextField.text = "Level: " + (event.someData.level);
		}
		
		private function onPauseClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.GAME_PAUSE_GAMESCREEN, null );
		}
		
		private function onQuitClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.GAME_EXIT_GAMESCREEN, null );
		}
	}
}