package;

#if android
import android.app.AlertDialog;
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
		#if android
		var uris:Map<String, String> = [];
		uris.set('files', Uri.fromFile(Context.getFilesDir()));
		uris.set('external_files', Uri.fromFile(Context.getExternalFilesDir(null)));
		uris.set('cache', Uri.fromFile(Context.getCacheDir()));
		uris.set('external_cache', Uri.fromFile(Context.getExternalCacheDir()));
		uris.set('obb', Uri.fromFile(Context.getObbDir()));

		var dirs:Map<String, Any> = [];
		dirs.set('files', Context.getFilesDir());
		dirs.set('external_files', Context.getExternalFilesDir(null));
		dirs.set('cache', Context.getCacheDir());
		dirs.set('external_cache', Context.getExternalCacheDir());
		dirs.set('obb', Context.getObbDir());
		dirs.set('uris', uris);

		var dlgAlert:AlertDialog = new AlertDialog();
		dlgAlert.setTitle('Cool Swag');
		dlgAlert.setMessage('Save a Json File with Dirs locations\nPress where you want to save it.');
		dlgAlert.setPositiveButton('Android Data', function()
		{
			File.saveContent(SUtil.getStorageDirectory(ANDROID_DATA) + 'StorageInfo.json', Json.stringify(dirs, "\t"));
			Toast.makeText('Saved in Android Data', Toast.LENGTH_LONG);
		});
		dlgAlert.setNegativeButton('Root', function()
		{
			File.saveContent(SUtil.getStorageDirectory(ROOT) + 'StorageInfo.json', Json.stringify(dirs, "\t"));
			Toast.makeText('Saved in Root', Toast.LENGTH_LONG);
		});
		dlgAlert.setCancelable(false);
		dlgAlert.show();
		#end

		super.create();
	}
}
