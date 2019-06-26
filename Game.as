package 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import sound.Sfx;
	import tetris.logic.GameLogic;
	import tetris.Assets;
	import tetris.ui.MainMenu;
	import tetris.ui.GameScreen;
	import tetris.ui.GameOverScreen;
	import tetris.ui.PauseScreen;
	import tetris.ui.GameScreenStatic;
	import tetris.ui.WindowManager;
	import tetris.sound.SoundManager;
	import tetris.TetrisEvent;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class Game extends Sprite   
	{
		private static const SCORE_MULT:Vector.<int> = Vector.<int>([10, 100, 220, 360, 500, 640, 760, 880, 1000]);
		private static const SPEED_START:int = 900;
		private static const SPEED_MULT:Number = 0.8;
		private var _tetris:GameLogic;
		private var _timer:Timer;
		private var _score:int; 
		private var _lines:int;
		private var _level:int;
		private var _pause:Boolean = false;
		private var _gameOver:Boolean = false;
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			WindowManager.init(this);
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.SOUND_ROTATE, onSoundRotate );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.SOUND_REFLECT, onSoundReflect );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.SOUND_REMOVE, onSoundRemove );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.SOUND_GAMEOVER, onSoundGameOver );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.SOUND_BUTTONDOWN, onSoundButtonDown );
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			showMenu();
			
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.APPLICATION_ENTRY_MAINMENU, onShowGameScreen );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.GAME_PLAY_GAMESCREENSTATIC, onGameStart);
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.APPLICATION_EXIT_GAMESCREENSTATIC, onQuitGameScreenStatic );
			
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.TETRIS_CONTAINER_CREATED_GAMESCREEN, onTetrisContainerCreated );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.GAME_PAUSE_GAMESCREEN, onGotoPause );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.GAME_EXIT_GAMESCREEN, onQuitGameScreen );
			
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.GAME_UN_PAUSE_PAUSESCREEN, onGotoUnPause);
			
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.APPLICATION_EXIT_GAMEOVERSCREEN, onQuitGameOverScreen);
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.GAME_PLAY_GAMEOVERSCREEN, onGameStart);
		}
		
		private function onSoundRotate(e:Event):void 
		{
			SoundManager.play("SOUND_ROTATE");
		}
		
		private function onSoundReflect(e:Event):void 
		{
			SoundManager.play("SOUND_REFLECT");
		}
		
		private function onSoundRemove(e:Event):void 
		{
			SoundManager.play("SOUND_REMOVE");
		}
		
		private function onSoundGameOver(e:Event):void 
		{
			SoundManager.play("SOUND_GAMEOVER");
		}
		
		private function onSoundButtonDown(e:Event):void 
		{
			SoundManager.play("SOUND_BUTTONDOWN");
		}
		
		private function showMenu():void 
		{
			WindowManager.show(MainMenu);
		}
		
		private function onShowGameScreen(e:Event):void 
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			WindowManager.hide(MainMenu);
			WindowManager.show(GameScreenStatic);
		}
		
		private function onGameStart(e:Event):void
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			if (_gameOver)
			{
				WindowManager.hide(GameScreen);
			}
			else
			{
				WindowManager.hide(GameScreenStatic);
			}
			
			WindowManager.show(GameScreen);
			startPlaying();	
		}
		
		private function onTetrisContainerCreated(event:TetrisEvent):void
		{
			TetrisEvent.dispatcher.removeEventListener( TetrisEvent.TETRIS_CONTAINER_CREATED_GAMESCREEN, onTetrisContainerCreated);
			_tetris = new GameLogic(10, 20, 20, 3, 0, event.someData);
			_timer = new Timer(SPEED_START);
		}
		
		
		private function onGotoPause(e:Event):void
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			stopPlaying();
			_pause = true;
			WindowManager.show(PauseScreen);
		}
		
		private function onGotoUnPause(e:Event):void
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			WindowManager.hide(PauseScreen);
			startPlaying();
			_pause = false;
		}
		
		private function onQuitGameScreenStatic(e:Event):void 
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			WindowManager.hide(GameScreenStatic);
			WindowManager.show(MainMenu);
		}
		
		private function onQuitGameOverScreen(e:Event):void 
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			TetrisEvent.dispatcher.addEventListener( TetrisEvent.TETRIS_CONTAINER_CREATED_GAMESCREEN, onTetrisContainerCreated);
			WindowManager.hide(GameScreen);
			WindowManager.hide(GameOverScreen);
			_gameOver = false;
			WindowManager.show(MainMenu);
		}
		
		private function onQuitGameScreen(e:Event):void 
		{
			TetrisEvent.dispatch( TetrisEvent.SOUND_BUTTONDOWN, null );
			stopPlaying();
			_gameOver = true;
			TetrisEvent.dispatch( TetrisEvent.SOUND_GAMEOVER, null );
			WindowManager.show(GameOverScreen);
		}
		
		private function startPlaying():void
		{
			if (_gameOver)
			{
				WindowManager.hide(GameOverScreen);
				_gameOver = false;
			}
			if (!_pause)
			{
				_score = 0;
				_lines = 0;
				_level = 0;
				_timer.delay = SPEED_START;
				_tetris.restart();
			}
			stage.addEventListener(Event.ENTER_FRAME, onStageEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onTetrisKeyDown);
			_timer.addEventListener(TimerEvent.TIMER, onTetrisTic);
			_timer.start();
		}
		
		private function stopPlaying():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onStageEnterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onTetrisKeyDown);
			_timer.removeEventListener(TimerEvent.TIMER, onTetrisTic);
			_timer.stop();
		}
		
		private function onStageEnterFrame(e:Event):void 
		{
			_tetris.draw();
			var scoreData:Object = {
				"score" : _score,
				"lines" : _lines,
				"level"	: _level + 1
			};
			TetrisEvent.dispatch(TetrisEvent.SCORE_UPDATED, scoreData);
		}
		
		private function onTetrisKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.DOWN) 
			{
				down();
			}
			else if (e.keyCode == Keyboard.UP)
			{
				TetrisEvent.dispatcher.addEventListener(TetrisEvent.FIGURE_ROTATE, onFigureRotate);
				_tetris.rotate();
			}
			else if (e.keyCode == Keyboard.LEFT)
			{
				_tetris.left();
			}
			else if (e.keyCode == Keyboard.RIGHT)
			{
				_tetris.right();
			}
		}
		
		private function onFigureRotate(e:TetrisEvent):void 
		{
			TetrisEvent.dispatcher.removeEventListener(TetrisEvent.FIGURE_ROTATE, onFigureRotate);
			TetrisEvent.dispatch( TetrisEvent.SOUND_ROTATE, null );
		}
		
		private function onFigureReflectInField(e:TetrisEvent):void 
		{
			TetrisEvent.dispatcher.removeEventListener(TetrisEvent.FIGURE_REFLECT_IN_FIELD, onFigureReflectInField);
			TetrisEvent.dispatch( TetrisEvent.SOUND_REFLECT, null );
		}
		
		private function onRemoveFilledLines(e:TetrisEvent):void 
		{
			TetrisEvent.dispatcher.removeEventListener(TetrisEvent.REMOVE_FILLED_LINES, onRemoveFilledLines);
			TetrisEvent.dispatch( TetrisEvent.SOUND_REMOVE, null );
		}
		
		private function onTetrisTic(e:TimerEvent = null):void 
		{
			down();
		}
		
		private function down():void
		{
			if (_tetris.down()) return;
			
			TetrisEvent.dispatcher.addEventListener(TetrisEvent.FIGURE_REFLECT_IN_FIELD, onFigureReflectInField);
			_tetris.reflectCurrentInField();
			
			TetrisEvent.dispatcher.addEventListener(TetrisEvent.REMOVE_FILLED_LINES, onRemoveFilledLines);
			if(!updateScore(_tetris.removeFilledLines())) 
			{
				TetrisEvent.dispatcher.removeEventListener(TetrisEvent.REMOVE_FILLED_LINES, onRemoveFilledLines);
			} 
			if (!_tetris.newFigure()) 
			{
				stopPlaying();
				_gameOver = true;
				TetrisEvent.dispatch( TetrisEvent.SOUND_GAMEOVER, null );
				WindowManager.show(GameOverScreen);
			}
		}
	
		private function updateScore(lines:int):int
		{
			_lines += lines;
			if (lines)
			{
				_score += SCORE_MULT[lines];
			}
			var level:int = int(_score / SPEED_START);
			if (level > _level) 
			{
				_level++;
				_timer.delay *= SPEED_MULT;
			}
			return lines;
		}
	}
}