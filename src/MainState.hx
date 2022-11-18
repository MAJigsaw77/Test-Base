package;

#if android
import android.FileBrowser;
import android.callback.CallBack;
import android.callback.CallBackEvent;
import android.net.Uri;
import android.widget.Toast;
#end
import flixel.FlxState;
import sys.io.File;
import haxe.Json;

class MainState extends FlxState
{
	override function create()
	{
		super.create();

		#if android
		CallBack.init();
		CallBack.addEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
		FileBrowser.open(FileBrowser.CREATE_DOCUMENT, Uri.fromFile(SUtil.getStorageDirectory()), 'Save a file NOW', 'application/json');
		#end
	}

	private function onActivityResult(e:CallBackEvent)
	{
		Toast.makeText('WORKING AYO', Toast.LENGTH_LONG);
		File.saveContent(SUtil.getStorageDirectory() + 'activity_result.json', Json.stringify(e.content, '\t'));

		CallBack.removeEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
	}
}
