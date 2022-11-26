package;

#if android
import android.FileBrowser;
import android.callback.CallBack;
import android.callback.CallBackEvent;
import android.os.Environment;
import android.net.Uri;
import android.widget.Toast;
#end
import ffmpeg.Version;
import ffmpeg.openfl.OpenFLBitmapVideo;
import flixel.FlxG;
import flixel.FlxState;
import sys.FileSystem;

using StringTools;

class State extends FlxState
{
	private var video:OpenFLBitmapVideo;

	override function create()
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		Toast.makeText('libavcodec version: ' + Version.getLibavcodecVersion() + '\n'
			 + 'libavutil version: ' + Version.getLibavutilVersion() + '\n'
			 + 'libavformat version: ' + Version.getLibavformatVersion() + '\n'
			 + 'libavfilter version: ' + Version.getLibavfilterVersion() + '\n'
			 + 'libswresample version: ' + Version.getLibswresampleVersion() + '\n'
			 + 'libswscale version: ' + Version.getLibswscaleVersion(), Toast.LENGTH_LONG);

		super.create();

		#if android
		CallBack.init();
		CallBack.addEventListener(CallBackEvent.ACTIVITY_RESULT, onActivityResult);
		FileBrowser.open(FileBrowser.GET_CONTENT);
		#end
	}

	override function update(elapsed:Float)
	{
		if (video != null && FlxG.game.contains(video) && FlxG.justPressed.SPACE #if android || FlxG.android.justReleased.BACK #end)
			video.play();

		super.update(elapsed);
	}

	private function onActivityResult(e:CallBackEvent)
	{
		if (e.content != null && e.content.data != null)
		{
			var daPath:String = e.content.data.getPath;

			if (daPath.contains('/document/primary:'))
				daPath = daPath.replace('/document/primary:', Environment.getExternalStorageDirectory() + '/');
			else if (daPath.contains('/document/'))
			{
				final daOldStorageEnter:String = daPath.substring(0, daPath.indexOf(':') + 1);
				daPath = daPath.replace(daOldStorageEnter, daOldStorageEnter.replace('/document/', '/storage/').replace(':', '/'));
			}

			if (FileSystem.exists(daPath))
			{
				video = new OpenFLBitmapVideo();
				video.open(daPath);
				FlxG.addChildBelowMouse(video);
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
