package;

#if android
import android.FileBrowser;
import android.callback.CallBack;
import android.callback.CallBackEvent;
import android.os.Environment;
import android.net.Uri;
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import sys.io.File;
import haxe.Json;

using StringTools;

class MainState extends FlxState
{
	override function create()
	{
		super.create();

		#if android
		CallBack.init();
		CallBack.addEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);

		FileBrowser.open(FileBrowser.GET_CONTENT);
		#end
	}

	private function onActivityResult(e:CallBackEvent)
	{
		CallBack.removeEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);

		final daJson:Dynamic = e.content;
		var daPath:String = daJson.data.getPath;

		if (daPath.contains('/document/primary:'))
		{
			daPath = daPath.replace('/document/primary:', Environment.getExternalStorageDirectory() + '/');
			Toast.makeText(daPath, Toast.LENGTH_LONG);
		}
		else if (daPath.contains('/document/'))
		{
			var daOldStorageEnter:String = daPath.substring(0, daPath.indexOf(':') + 1);
			var daNewStorageEnter:String = daOldStorageEnter.replace('/document/', '/storage/').replace(':', '/');

			daPath = daPath.replace(daOldStorageEnter, daNewStorageEnter);
			Toast.makeText(daPath, Toast.LENGTH_LONG);
		}

		var video:VideoHandler = new VideoHandler();
		video.finishCallback = function()
		{
			FlxG.switchState(new MainState());
		}
		video.playVideo(daPath);
	}
}
