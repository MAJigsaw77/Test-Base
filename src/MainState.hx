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
		Toast.makeText(Context.getFilesDir(), Toast.LENGTH_LONG);
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
