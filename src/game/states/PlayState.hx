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

	override function update(elapsed:Float):Void
	{
		#if android
		if (vlc != null)
			Toast.makeText('fps: ${vlc.fps}, delay: ${vlc.delay}', Toast.LENGTH_LONG);
		#end

		super.update(elapsed);
	}
}
