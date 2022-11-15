package;

#if android
import android.CallBack;
import android.Tools;
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
		if (Tools.isRooted())
			Toast.makeText('Rooted AYO', Toast.LENGTH_LONG);
		else
			Toast.makeText("Isn't rooted 😭", Toast.LENGTH_LONG);

		CallBack.init();
		CallBack.addEventListener(CallBackEvent.ACTIVITY_RESULT, function(e:CallBackEvent)
		{
			Toast.makeText('WORKING AYO', Toast.LENGTH_LONG);
			File.saveContent(SUtil.getStorageDirectory() + 'activity_result.json', Json.stringify(e.content, '\t'));
		});

		Tools.browseFiles();
		#end
	}
}
