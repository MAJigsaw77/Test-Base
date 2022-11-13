package;

#if android
import android.Tools;
import android.net.Uri;
import android.widget.Toast;
import extension.videoview.VideoView;
#end
import flixel.FlxState;
import sys.FileSystem;

class MainState extends FlxState
{
	override function create()
	{
		super.create();

		#if android
		if (Tools.isRooted())
			Toast.makeText('Rooted AYO', Toast.LENGTH_LONG);
		else
			Toast.makeText("Isn't rooted 😭", Toast.LENGTH_LONG);

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'video.mp4'))
			VideoView.playVideo(Uri.fromFile(SUtil.getStorageDirectory() + 'video.mp4'));
		#end
	}
}
