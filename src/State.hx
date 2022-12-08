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

using StringTools;

class State extends FlxState
{
	override function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		super.create();

		#if android
		CallBack.init();
		CallBack.addEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);

		FileBrowser.open(FileBrowser.GET_CONTENT);
		#end
	}

	private function onActivityResult(e:CallBackEvent):Void
	{
		if (e.content != null && e.content.data != null)
		{
			var daPath:String = e.content.data.path;

			if (daPath.startsWith('/document/primary:'))
				daPath = daPath.replace('/document/primary:', Environment.getExternalStorageDirectory() + '/');
			else if (daPath.startsWith('/document/') && daPath.contains(':'))
			{
				final daOldStorageEnter:String = daPath.substring(0, daPath.indexOf(':') + 1);
				daPath = daPath.replace(daOldStorageEnter, daOldStorageEnter.replace('/document/', '/storage/').replace(':', '/'));
			}

			var video:VideoHandler = new VideoHandler();
			video.finishCallback = function()
			{
				CallBack.removeEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
				FlxG.resetGame();
			}
			video.playVideo(daPath);
		}
	}
}
