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

	override function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		video = new VideoSprite();
		video.bitmap.canUseAutoResize = false;
		video.bitmap.canSkip = false;
		video.bitmap.width = 640;
		video.bitmap.height = 360;

		video.readyCallback = function()
		{
			canMoveTheVideo = true;
			video.screenCenter();
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
	private var position:FlxPoint = new FlxPoint(0, 0);

	override function update(elapsed:Float):Void
	{
		if (video != null && canMoveTheVideo)
		{
			elapsedTime += elapsed;
			position.x = -Math.sin((elapsedTime) * 2) * 100;
			position.y = -Math.cos((elapsedTime)) * 50;

			video.x += (position.x - video.x);
			video.y += (position.y - video.y);
		}
		else
		{
			elapsedTime = 0;
			position.x = 0;
			position.y = 0;

			if (video != null)
			{
				video.x = 0;
				video.y = 0;
			}
		}

		super.update(elapsed);
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
