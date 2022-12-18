package;

#if android
import android.widget.Toast;
#end
import openfl.Lib;
import openfl.display.Sprite;
import vlc.VLCBitmap;
import sys.FileSystem;

class Main extends Sprite
{
	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		var vlc:VLCBitmap = new VLCBitmap();
		addChild(vlc);

		addChild(new Overlay(10, 10));

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'video.mp4'))
		{
			vlc.playVideo(SUtil.getStorageDirectory() + 'video.mp4');
			#if android
			Toast.makeText('Should start playing?', Toast.LENGTH_LONG, 17);
			#end
		}
	}
}
