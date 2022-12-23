package game.states;

import flixel.FlxG;
import flixel.FlxState;
import ffmpeg.openfl.OpenFLBitmapVideo;
import ffmpeg.Version;

class PlayState extends FlxState
{
	override public function create()
	{
		var versions:Array<String> = [];
		versions.push('libavcodec version: ${Version.getLibavcodecVersion()}');
		versions.push('libavutil version: ${Version.getLibavutilVersion()}');
		versions.push('libavformat version: ${Version.getLibavformatVersion()}');
		versions.push('libavfilter version: ${Version.getLibavfilterVersion()}');
		versions.push('libswresample version: ${Version.getLibswresampleVersion()}');
		versions.push('libswscale version: ${Version.getLibswscaleVersion()}');
		Toast.makeText(versions.join('\n'), Toast.LENGTH_SHORT);

		super.create();

		var video:OpenFLBitmapVideo = new OpenFLBitmapVideo();
		FlxG.addChildBelowMouse(video);
		video.open(SUtil.getStorageDirectory() + 'assets/videos/sarv.gif');
	}
}
