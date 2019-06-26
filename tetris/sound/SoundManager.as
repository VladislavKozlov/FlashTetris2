package tetris.sound 
{
	import flash.utils.Dictionary;
	import sound.Sfx;
	import tetris.Assets;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class SoundManager 
	{
		private static var _soundRotateSfx:Sfx = new Sfx(Assets.soundRotate);
		private static var _soundReflectSfx:Sfx = new Sfx(Assets.soundReflect);
		private static var _soundRemoveLinesSfx:Sfx = new Sfx(Assets.soundRemove);
		private static var _soundGameOverSfx:Sfx = new Sfx(Assets.soundGameOver);
		private static var _soundButtonDownSfx:Sfx = new Sfx(Assets.soundButtonDown);
		
		private static var _sounds:Object = 
		{
			"SOUND_ROTATE"      :_soundRotateSfx,
			"SOUND_REFLECT"     :_soundReflectSfx,
			"SOUND_REMOVE"      :_soundRemoveLinesSfx,
			"SOUND_GAMEOVER"    :_soundGameOverSfx,
			"SOUND_BUTTONDOWN"  :_soundButtonDownSfx
		}
		
		private static var _soundsDict:Dictionary = new Dictionary();
		
		public static function play(soundName:String):void
		{
			var soundSfx:Sfx;
			if (!_soundsDict.hasOwnProperty(soundName))
			{
				soundSfx = _sounds[soundName];
				_soundsDict[soundName] = soundSfx;
			}
			soundSfx = _soundsDict[soundName];
			soundSfx.play();
		}
	}
}