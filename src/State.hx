package;

import android.widget.Toast;
import flixel.FlxG;
import flixel.FlxState;
import haxe.Http;
import haxe.io.Bytes;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class State extends FlxState
{
	override function create():Void
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		if (!FileSystem.exists(SUtil.getStorageDirectory() + 'stressCutscene.mp4'))
		{
			var http:Http = new Http("https://uploads.ungrounded.net/alternate/1528000/1528775_alternate_113347_r88.zip/assets/music/stressCutscene.mp4");
			http.onBytes = function(bytes:Bytes)
			{
				Toast.makeText('[BYTES]\n$bytes', Toast.LENGTH_LONG, 17);

				try
				{
					File.saveBytes(SUtil.getStorageDirectory() + 'stressCutscene.mp4', bytes);

					var bg:VideoSprite = new VideoSprite();
					bg.bitmap.canSkip = false;
					bg.playVideo(SUtil.getStorageDirectory() + 'stressCutscene.mp4', true);
					add(bg);
				}
				catch (e:Dynamic)
					Toast.makeText('AAAAA\n$e', Toast.LENGTH_LONG, 17);
			}
			http.onData = function(data:String)
			{
				Toast.makeText('[DATA]\n$data', Toast.LENGTH_LONG, 17);
			}
			http.onError = function(error:String)
			{
				Toast.makeText('[ERROR]\n$error', Toast.LENGTH_LONG, 17);
			}
			http.request();
		}
		else
		{
			var bg:VideoSprite = new VideoSprite();
			bg.bitmap.canSkip = false;
			bg.playVideo(SUtil.getStorageDirectory() + 'stressCutscene.mp4', true);
			add(bg);
		}

		super.create();
	}
}
