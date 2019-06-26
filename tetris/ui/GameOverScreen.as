package tetris.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import tetris.visual.UIButton;
	import tetris.Assets;
	import tetris.TetrisEvent;
	
	/**
	 *
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class GameOverScreen extends Sprite 
	{
		private var _buttonPlay:UIButton;
		private var _buttonQuit:UIButton;
		
		public function GameOverScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
		}
		
		private function onAdddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
			var gameOverScreenContainer:Sprite = new Sprite();
			addChild(gameOverScreenContainer);
			
			var background:Bitmap = new Bitmap();
			background = Assets.backgroundGeneral;
			background.smoothing = true;
			background.alpha = 0.1;
			gameOverScreenContainer.addChild(background);
			
			background.x = (gameOverScreenContainer.width - background.width) / 2;
			background.y = (gameOverScreenContainer.height - background.height) / 2;
			
			var tetrisBackground:Bitmap = new Bitmap();
			tetrisBackground = Assets.backgroundGameOver;
			tetrisBackground.smoothing = true;
			tetrisBackground.alpha = 0.5;
			gameOverScreenContainer.addChild(tetrisBackground);
			
			tetrisBackground.x = (background.width - tetrisBackground.width) / 2;
			tetrisBackground.y = (background.height - tetrisBackground.height) / 2;
			
			var gameLogo:Bitmap = new Bitmap();
			gameLogo = Assets.logoBitmap;
			gameLogo.x = tetrisBackground.x + 200;
			gameLogo.y = tetrisBackground.y + 349;
			gameOverScreenContainer.addChild(gameLogo);
			
			var backgroundButton:Bitmap = new Bitmap();
			backgroundButton = Assets.backgroundButton;
			backgroundButton.x = tetrisBackground.x + 200;
			backgroundButton.y = tetrisBackground.y + 200;
			backgroundButton.smoothing = true;
			gameOverScreenContainer.addChild(backgroundButton);
			
			var buttonPlayBp:Bitmap = new Bitmap();
			buttonPlayBp = Assets.buttonPlay;
			
			_buttonPlay = new UIButton(null, buttonPlayBp);
			_buttonPlay.x = tetrisBackground.x + 220;
			_buttonPlay.y = tetrisBackground.y + 250;
			gameOverScreenContainer.addChild(_buttonPlay);
			_buttonPlay.addEventListener(MouseEvent.CLICK, onPlayClick);
			
			var buttonQuitBp:Bitmap = new Bitmap();
			buttonQuitBp = Assets.buttonQuit;
			
			_buttonQuit = new UIButton(null, buttonQuitBp);
			_buttonQuit.x = tetrisBackground.x + 220;
			_buttonQuit.y = tetrisBackground.y + 300;
			gameOverScreenContainer.addChild(_buttonQuit);
			_buttonQuit.addEventListener(MouseEvent.CLICK, onQuitClick);
		}
		
		private function onPlayClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.GAME_PLAY_GAMEOVERSCREEN, null );
		}
		
		private function onQuitClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.APPLICATION_EXIT_GAMEOVERSCREEN, null );
		}
	}
}