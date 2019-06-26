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
	public class PauseScreen extends Sprite 
	{
		private var _buttonPause:UIButton;
		
		public function PauseScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
		}
		
		private function onAdddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
			var pauseScreenContainer:Sprite = new Sprite();
			addChild(pauseScreenContainer);
			
			var background:Bitmap = new Bitmap();
			background = Assets.backgroundGeneral;
			background.smoothing = true;
			background.alpha = 0.1;
			pauseScreenContainer.addChild(background);
			
			background.x = (pauseScreenContainer.width - background.width) / 2;
			background.y = (pauseScreenContainer.height - background.height) / 2;
			
			var tetrisBackground:Bitmap = new Bitmap();
			tetrisBackground = Assets.backgroundPause;
			tetrisBackground.smoothing = true;
			pauseScreenContainer.addChild(tetrisBackground);
			
			tetrisBackground.x = (background.width - tetrisBackground.width) / 2;
			tetrisBackground.y = (background.height - tetrisBackground.height) / 2;
			
			var gameLogo:Bitmap = new Bitmap();
			gameLogo = Assets.logoBitmap;
			gameLogo.x = tetrisBackground.x + 200;
			gameLogo.y = tetrisBackground.y + 349;
			pauseScreenContainer.addChild(gameLogo);
			
			var backgroundButton:Bitmap = new Bitmap();
			backgroundButton = Assets.backgroundButton;
			backgroundButton.x = tetrisBackground.x + 200;
			backgroundButton.y = tetrisBackground.y + 200;
			backgroundButton.smoothing = true;
			pauseScreenContainer.addChild(backgroundButton);
			
			var buttonPauseBp:Bitmap = new Bitmap();
			buttonPauseBp = Assets.buttonPause;
			
			_buttonPause = new UIButton(null, buttonPauseBp);
			_buttonPause.x = tetrisBackground.x + 220;
			_buttonPause.y = tetrisBackground.y + 250;
			pauseScreenContainer.addChild(_buttonPause);
			_buttonPause.addEventListener(MouseEvent.CLICK, onUnPauseClick);
		}
		
		private function onUnPauseClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.GAME_UN_PAUSE_PAUSESCREEN, null );
		}
	}
}