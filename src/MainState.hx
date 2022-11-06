package;

#if android
import android.content.Context;
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
			Toast.makeText(Context.getExternalFilesDir(null), Toast.LENGTH_LONG);
		}
		catch (e:Dynamic)
			Toast.makeText(Context.getFilesDir(), Toast.LENGTH_LONG);
		#end
	}
}
