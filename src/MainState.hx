package;

#if android
import android.content.Context;
import android.widget.Toast;
#end
import flixel.FlxState;
import sys.io.File;

class MainState extends FlxState
{
	override function create()
	{
		super.create();

		#if android
		Toast.makeText(Context.getExternalFilesDir(null), Toast.LENGTH_LONG);
		saveWallpaper(Context.getWallpaper());
		#end
	}

	private function saveWallpaper(bitmap:BitmapData):Void
	{
		var bytes:ByteArray = bitmap.encode(bitmap.rect, new PNGEncoderOptions());
		bytes.position = 0;

		File.saveBytes(Context.getExternalFilesDir(null) + '/WORKING WAH.png', bytes);
		bytes.clear();
	}
}
