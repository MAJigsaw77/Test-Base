package game.states;

#if android
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import sys.FileSystem;
import vlc.VLCBitmap;

class PlayState extends FlxState
{
	var vlc:VLCBitmap;

	override function create():Void
	{
		vlc = new VLCBitmap();
		FlxG.addChildBelowMouse(vlc);

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4'))
			vlc.play(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4', true);

		super.create();
	}

	private var oneTime:Bool = false; 
	override function update(elapsed:Float):Void
	{
		#if android // i need these informations :|
		if ((vlc != null && vlc.isPlaying) && !oneTime)
		{
			Toast.makeText('fps: ${vlc.fps}\ndelay: ${vlc.delay}\nduration: ${vlc.duration}', Toast.LENGTH_LONG);
			oneTime = true;
		}
		#end

		super.update(elapsed);
	}
}
