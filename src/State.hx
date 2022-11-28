package;

#if android
import android.content.Context;
import android.kizzy.KizzyClient;
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

		super.create();

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'token.json'))
		{
			var token:Dynamic = Json.parse(File.getContent(SUtil.getStorageDirectory() + 'token.json'));

			var kizzyClient:KizzyClient = new KizzyClient(token.value);
			kizzyClient.setApplicationID('378534231036395521');
			kizzyClient.setName('Kizzy RPC Client Android');
			kizzyClient.setDetails('When RPC is sus');
			kizzyClient.setLargeImage('attachments/973256105515974676/983674644823412798/unknown.png');
			kizzyClient.setSmallImage('attachments/948828217312178227/948840504542498826/Kizzy.png');
			kizzyClient.setButton1('YouTube', 'https://youtube.com/@m.a.jigsaw7297');
			kizzyClient.setType(0);
			kizzyClient.setState('State');
			kizzyClient.setStatus('idle');
			kizzyClient.closeOnDestroy(true);
			kizzyClient.rebuildClient();
		}
	}
}
