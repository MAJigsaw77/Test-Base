package;

#if android
import android.FileBrowser;
import android.callback.CallBack;
import android.callback.CallBackEvent;
import android.content.Context;
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

		FileBrowser.open(FileBrowser.CREATE_DOCUMENT, Context.getExternalFilesDir(null), 'application/json');
		#end
	}

	private function onActivityResult(e:CallBackEvent)
	{
		File.saveContent(SUtil.getStorageDirectory() + 'activity_result.json', Json.stringify(e.content, '\t'));
		Toast.makeText('WORKING AYO', Toast.LENGTH_LONG);

		CallBack.removeEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
	}
}
