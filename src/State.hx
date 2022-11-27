package;

#if android
import android.content.Context;
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import sys.FileSystem;

using StringTools;

class State extends FlxState
{
	override function create()
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		try
		{
			var daArray:Array<String> = FileSystem.readDirectory(Context.getFilesDir());
			Toast.makeText('HOLY SHIT, IT WORKED!!!\n' + daArray, Toast.LENGTH_LONG);
		}
		catch (e:Dynamic)
			Toast.makeText('FUCK ಠ⁠︵⁠ಠ' + '\n' + e, Toast.LENGTH_LONG);

		super.create();
	}
}
