package;

#if android
import android.app.AlertDialog;
#end
import flixel.FlxState;
import sys.io.File;
import haxe.Json;

class MainState extends FlxState
{
	override function create()
	{
		#if android
		var dlgAlert:AlertDialog = new AlertDialog();
		dlgAlert.setTitle('Cool Swag');
		dlgAlert.setMessage('Hehehehehehheheheheheheheheheheh');
		dlgAlert.setPositiveButton('Positive', function()
		{
			Sys.exit(0);
		});
		dlgAlert.setNegativeButton('Negative', function()
		{
			Sys.exit(0);
		});
		dlgAlert.setCancelable(false);
		dlgAlert.show();
		#end

		super.create();
	}
}
