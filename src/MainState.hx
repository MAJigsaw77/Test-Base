package;

#if android
import android.content.Context;
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
		var dirs:Map<String, String> = [];
		dirs.set('files', Context.getFilesDir());
		dirs.set('external_files', Context.getExternalFilesDir(null));
		dirs.set('cache', Context.getCacheDir());
		dirs.set('external_cache', Context.getExternalCacheDir());
		dirs.set('obb', Context.getObbDir());
		dirs.set('no_backup', Context.getNoBackupFilesDir());

		try
		{
			File.saveContent(SUtil.getStorageDirectory(ANDROID_DATA) + 'StorageInfo.json', Json.stringify(dirs, "\t"));
			Toast.makeText('Saved in Android Data', Toast.LENGTH_LONG);
		}
		catch (e:Dynamic)
		{
			File.saveContent(SUtil.getStorageDirectory(ROOT) + 'StorageInfo.json', Json.stringify(dirs, "\t"));
			Toast.makeText('Saved in Root', Toast.LENGTH_LONG);
		}
		#end

		super.create();
	}
}
