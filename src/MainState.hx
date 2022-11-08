package;

#if android
import android.widget.Toast;
#end
import flixel.FlxState;

class MainState extends FlxState
{
	override function create()
	{
		super.create();

		#if android
		try
		{
			Toast.makeText(SUtil.getStorageDirectory(ANDROID_DATA), Toast.LENGTH_LONG);
		}
		catch (e:Dynamic)
			Toast.makeText(SUtil.getStorageDirectory(ROOT), Toast.LENGTH_LONG);
		#end
	}
}
