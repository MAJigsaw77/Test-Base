package game.states;

#if android
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import vlc.VLCBitmap;

class PlayState extends FlxState
{
	override public function create()
	{
		var vlc:VLCBitmap = new VLCBitmap();
		FlxG.addChildBelowMouse(vlc);

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4'))
		{
			#if android
			Toast.makeText('Should start playing?', Toast.LENGTH_LONG, 17);
			#end
			vlc.play(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4');
		}

		super.create();
	}
}
