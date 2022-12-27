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
		if (vlc != null && (vlc.videoWidth > 0 || vlc.videoHeight > 0))
			Toast.makeText('w: ${vlc.videoWidth}, h: ${vlc.videoHeight}', Toast.LENGTH_LONG, 17);
		#end

		super.update(elapsed);
	}
}
