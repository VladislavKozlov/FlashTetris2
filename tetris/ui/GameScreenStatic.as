package tetris.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import tetris.visual.UIButton;
	import tetris.Assets;
	import tetris.TetrisEvent;
	
	/**
	 *
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class GameScreenStatic extends Sprite 
	{
		
		private var _scoreTextField:TextField;
		private var _linesTextField:TextField;
		private var _levelTextField:TextField;
		private var _buttonPlay:UIButton;
		private var _buttonQuit:UIButton;
		
		public function GameScreenStatic() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
		}
		
		private function onAdddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
			var gameScreenStaticContainer:Sprite = new Sprite();
			addChild(gameScreenStaticContainer);
			
			var background:Bitmap = new Bitmap();
			background = Assets.backgroundGeneral;
			background.smoothing = true;
			gameScreenStaticContainer.addChild(background);
			
			background.x = (gameScreenStaticContainer.width - background.width) / 2;
			background.y = (gameScreenStaticContainer.height - background.height) / 2;
			
			var tetrisBackground:Bitmap = new Bitmap();
			tetrisBackground = Assets.backgroundTetris;
			tetrisBackground.smoothing = true;
			gameScreenStaticContainer.addChild(tetrisBackground);
			
			tetrisBackground.x = (background.width - tetrisBackground.width) / 2;
			tetrisBackground.y = (background.height - tetrisBackground.height) / 2;
			
			_levelTextField = createTextField(tetrisBackground.x + 220, tetrisBackground.y + 120, TextFieldAutoSize.LEFT, TextFormatAlign.LEFT);
			_levelTextField.text = "Level: 1";
			_linesTextField = createTextField(tetrisBackground.x + 220, tetrisBackground.y + 150, TextFieldAutoSize.LEFT, TextFormatAlign.LEFT);
			_linesTextField.text = "Lines: 0";
			_scoreTextField = createTextField(tetrisBackground.x + 220, tetrisBackground.y + 180, TextFieldAutoSize.LEFT, TextFormatAlign.LEFT);
			_scoreTextField.text = "Score: 0";
			
			var gameLogo:Bitmap = new Bitmap();
			gameLogo = Assets.logoBitmap;
			gameLogo.x = tetrisBackground.x + 200;
			gameLogo.y = tetrisBackground.y + 349;
			gameScreenStaticContainer.addChild(gameLogo);
			
			var buttonPlayBp:Bitmap = new Bitmap();
			buttonPlayBp = Assets.buttonPlay;
			
			_buttonPlay = new UIButton(null, buttonPlayBp);
			_buttonPlay.x = tetrisBackground.x + 220;
			_buttonPlay.y = tetrisBackground.y + 250;
			gameScreenStaticContainer.addChild(_buttonPlay);
			_buttonPlay.addEventListener(MouseEvent.CLICK, onPlayClick);
			
			var buttonQuitBp:Bitmap = new Bitmap();
			buttonQuitBp = Assets.buttonQuit;
			
			_buttonQuit = new UIButton(null, buttonQuitBp);
			_buttonQuit.x = tetrisBackground.x + 220;
			_buttonQuit.y = tetrisBackground.y + 300;
			gameScreenStaticContainer.addChild(_buttonQuit);
			_buttonQuit.addEventListener(MouseEvent.CLICK, onQuitClick);
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
		
		private function onPlayClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.GAME_PLAY_GAMESCREENSTATIC, null );
		}
		
		private function onQuitClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.APPLICATION_EXIT_GAMESCREENSTATIC, null );
		}
	}
}