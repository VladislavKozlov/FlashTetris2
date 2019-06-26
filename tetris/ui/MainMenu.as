package tetris.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import tetris.visual.UIButton;
	import tetris.Assets;
	import tetris.TetrisEvent;
	
	/**
	 *
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class MainMenu extends Sprite 
	{
		private var _entryButton:UIButton;
		
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
		}
		
		private function onAdddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdddedToStage);
			var mainMenuContainer:Sprite = new Sprite();
			addChild(mainMenuContainer);
			
			var background:Bitmap = new Bitmap();
			background = Assets.backgroundBitmap;
			background.smoothing = true;
			mainMenuContainer.addChild(background);
			
			var buttonsContainer:Sprite = new Sprite();
			mainMenuContainer.addChild(buttonsContainer);
			
			_entryButton = new UIButton("ENTRY");
			buttonsContainer.addChild(_entryButton);
			_entryButton.addEventListener(MouseEvent.CLICK, onEntryClick);
			
			buttonsContainer.x = (mainMenuContainer.width - buttonsContainer.width) / 2;
			buttonsContainer.y = (mainMenuContainer.height - buttonsContainer.height) / 2 + mainMenuContainer.width / 6;
			
		}
		
		private function onEntryClick(event:MouseEvent):void
		{
			TetrisEvent.dispatch( TetrisEvent.APPLICATION_ENTRY_MAINMENU, null );
		}
	}
}