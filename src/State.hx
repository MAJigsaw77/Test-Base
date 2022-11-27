package;

#if android
import android.content.Context;
inport android.kizzy.KizzyClient;
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import openfl.Lib;
import haxe.Json;
import sys.io.File;
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

		if (FileSystem.exists(SUtil.getStoragePath() + 'token.json'))
		{
			var token:Dynamic = Json.parse(File.getContent(SUtil.getStoragePath() + 'token.json')));

			var kizzyClient:KizzyClient = new KizzyClient(token.value);
			kizzyClient.setApplicationID('378534231036395521');
			kizzyClient.setName('Kizzy RPC Client Android');
			kizzyClient.setDetails('Hello World!');
			kizzyClient.setType(3);
			kizzyClient.setState('State');
			kizzyClient.setStatus('online');
			kizzyClient.rebuildClient();

			Lib.application.window.onClose.add(function()
			{
				if (kizzyClient.isClientRunning())
					kizzyClient.closeClient();
			});
		}

		super.create();
	}
}
