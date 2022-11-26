package;

#if android
import android.widget.Toast;
#end
import ffmpeg.Version;
import flixel.FlxG;
import flixel.FlxState;

using StringTools;

class State extends FlxState
{
	override function create()
	{
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		super.create();

		Toast.makeText('libavcodec version: ' + Version.getLibavcodecVersion() + '\n'
			 + 'libavutil version: ' + Version.getLibavutilVersion() + '\n'
			 + 'libavformat version: ' + Version.getLibavformatVersion() + '\n'
			 + 'libavfilter version: ' + Version.getLibavfilterVersion() + '\n'
			 + 'libswresample version: ' + Version.getLibswresampleVersion() + '\n'
			 + 'libswscale version: ' + Version.getLibswscaleVersion() + '\n', Toast.LENGTH_LONG);
	}
}
