package;

#if android
import android.FileBrowser;
import android.callback.CallBack;
import android.callback.CallBackEvent;
import android.os.Environment;
import android.net.Uri;
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import sys.FileSystem;
import haxe.Json;

using StringTools;

class State extends FlxState
{
	private var video:VideoSprite;
	private var canMoveTheVideo:Bool = false;
	private var position:FlxPoint = new FlxPoint(0, 0);

	override function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		video = new VideoSprite();
		video.bitmap.width = 640;
		video.bitmap.height = 360;
		video.bitmap.canUseAutoResize = false;
		video.bitmap.canSkip = false;
		video.readyCallback = function()
		{
			video.screenCenter();
			position.x = video.x;
			position.y = video.y;
			canMoveTheVideo = true;
		}
		video.finishCallback = function()
		{
			if (CallBack.hasEventListener(CallBackEvent.ACTIVITY_RESULT))
				CallBack.removeEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);

			FlxG.resetGame();
		}

		super.create();

		#if android
		CallBack.init();
		CallBack.addEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
		FileBrowser.open(FileBrowser.GET_CONTENT);
		#end
	}

	private var elapsedTime:Float = 0;

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (video != null && canMoveTheVideo)
		{
			elapsedTime += elapsed;

			for (i in 0...7)
			{
				video.x = position.x + 32 * Math.cos(((elapsedTime / 1000) * 3) + i * 0.25) * Math.PI;
				video.y = position.y + 32 * Math.sin(((elapsedTime / 1000) * 3) + i * 0.25) * Math.PI;
			}
		}
		else
			elapsedTime = 0;
	}

	private function onActivityResult(e:CallBackEvent)
	{
		if (e.content != null && e.content.data != null)
		{
			var daPath:String = e.content.data.path;

			if (daPath.startsWith('/document/primary:'))
				daPath = daPath.replace('/document/primary:', Environment.getExternalStorageDirectory() + '/');
			else if (daPath.startsWith('/document/') && daPath.contains(':'))
			{
				final daOldStorageEnter:String = daPath.substring(0, daPath.indexOf(':') + 1);
				daPath = daPath.replace(daOldStorageEnter, daOldStorageEnter.replace('/document/', '/storage/').replace(':', '/'));
			}

			if (FileSystem.exists(daPath))
			{
				if (video != null)
					video.playVideo(daPath, true);
			}
			else
			{
				Toast.makeText(daPath + ": Doesn't exists", Toast.LENGTH_LONG);
				CallBack.removeEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
				FlxG.resetGame();
			}
		}
	}
}
