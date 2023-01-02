package game.states;

#if android
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import openfl.Lib;
import sys.FileSystem;
import vlc.VLCBitmap;

class PlayState extends FlxState
{
	var vlc:VLCBitmap;

	override function create():Void
	{
		vlc = new VLCBitmap();
		vlc.onEndReached = function()
		{
			vlc.dispose();
			Toast.makeText('dispose is done AYO', Toast.LENGTH_LONG);
		}
		FlxG.addChildBelowMouse(vlc);

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4'))
			vlc.play(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4');

		super.create();
	}

	private var oneTime:Bool = false; 
	override function update(elapsed:Float):Void
	{
		#if android // i need these informations :|
		if ((vlc != null && vlc.isPlaying) && !oneTime)
		{
			Toast.makeText('fps: ${vlc.fps}\ndelay: ${vlc.delay}\nduration: ${vlc.duration}', Toast.LENGTH_LONG);
			oneTime = true;
		}
		#end

		if (vlc != null && vlc.bitmapData != null)
		{
			vlc.width = calcSize(0);
			vlc.height = calcSize(1);
		}

		super.update(elapsed);
	}

	private function calcSize(Ind:Int):Float
	{
		var appliedWidth:Float = Lib.current.stage.stageHeight * (FlxG.width / FlxG.height);
		var appliedHeight:Float = Lib.current.stage.stageWidth * (FlxG.height / FlxG.width);

		if (appliedHeight > Lib.current.stage.stageHeight)
			appliedHeight = Lib.current.stage.stageHeight;

		if (appliedWidth > Lib.current.stage.stageWidth)
			appliedWidth = Lib.current.stage.stageWidth;

		switch (Ind)
		{
			case 0:
				return appliedWidth;
			case 1:
				return appliedHeight;
		}

		return 0;
	}
}
