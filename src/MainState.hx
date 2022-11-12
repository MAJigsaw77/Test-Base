package;

#if android
import android.Tools;
import android.widget.Toast;
#end
import flixel.FlxState;

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
		#end
	}
}
