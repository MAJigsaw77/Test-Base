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
		Toast.makeText('HELLO WORLD!!!!', Toast.LENGTH_LONG);
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
