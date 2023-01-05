package game.states;

#if android
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import openfl.Lib;
import sys.FileSystem;

class PlayState extends FlxState
{
	var vlc:VideoHandler;

	override function create():Void
	{
		vlc = new VideoHandler();
		vlc.finishCallback = function()
		{       #if android 
			Toast.makeText('dispose is done!', Toast.LENGTH_LONG); 
		        #end 
		}
		if (FileSystem.exists(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4'))
			vlc.playVideo(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4');

		super.create();
	}

	private var oneTime:Bool = false; 
	override function update(elapsed:Float):Void
	{
		 // i need these informations :|
		if ((vlc != null && vlc.isPlaying) && !oneTime)
		{       #if android
			Toast.makeText('fps: ${vlc.fps}\ndelay: ${vlc.delay}\nduration: ${vlc.duration}', Toast.LENGTH_LONG); 
		        #end 
			oneTime = true;
		}
		

		super.update(elapsed);
	}
}
