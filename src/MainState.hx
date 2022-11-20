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
import sys.FileSystem;
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

		if (e.content != null && e.content.data != null)
		{
			var daPath:String = e.content.data.getPath;

			if (daPath.contains('/document/primary:'))
				daPath = daPath.replace('/document/primary:', Environment.getExternalStorageDirectory() + '/');
			else if (daPath.contains('/document/'))
			{
				var daOldStorageEnter:String = daPath.substring(0, daPath.indexOf(':') + 1);
				var daNewStorageEnter:String = daOldStorageEnter.replace('/document/', '/storage/').replace(':', '/');

				daPath = daPath.replace(daOldStorageEnter, daNewStorageEnter);
			}

			if (FileSystem.exists(daPath))
			{
				var video:VideoHandler = new VideoHandler();
				video.finishCallback = function()
				{
					FlxG.resetGame();
				}
				video.playVideo(daPath);
			}
			else
			{
				Toast.makeText(daPath + ": Doesn't exists", Toast.LENGTH_LONG);
				FlxG.resetGame();
			}
		}
	}
}
