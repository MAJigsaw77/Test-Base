package game.states;

#if android
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import ffmpeg.openfl.OpenFLBitmapVideo as FfmpegPlayer;
import ffmpeg.Version;

class PlayState extends FlxState
{
	override public function create()
	{
		var versions:Array<String> = [];
		versions.push('avcodec version: ${Version.getLibavcodecVersion()}');
		versions.push('avutil version: ${Version.getLibavutilVersion()}');
		versions.push('avformat version: ${Version.getLibavformatVersion()}');
		versions.push('avfilter version: ${Version.getLibavfilterVersion()}');
		versions.push('swresample version: ${Version.getLibswresampleVersion()}');
		versions.push('swscale version: ${Version.getLibswscaleVersion()}');

		#if android
		Toast.makeText(versions.join('\n'), Toast.LENGTH_SHORT);
		#end

		super.create();

		var video:FfmpegPlayer = new FfmpegPlayer();
		FlxG.addChildBelowMouse(video);
		video.open(SUtil.getStorageDirectory() + 'assets/videos/sarv.mp4');
	}
}
