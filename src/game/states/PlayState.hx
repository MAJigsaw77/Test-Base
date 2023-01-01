package game.states;

#if android
import android.widget.Toast;
#end
import flixel.FlxG;
import flixel.FlxState;
import sys.FileSystem;
import vlc.VLCBitmap;

class PlayState extends FlxState
{
	var vlc:VLCBitmap;

	override function create():Void
	{
		vlc = new VLCBitmap();
		vlc.width = calcSize(0);
		vlc.height = calcSize(1);
		FlxG.addChildBelowMouse(vlc);

		if (FileSystem.exists(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4'))
			vlc.play(SUtil.getStorageDirectory() + 'assets/videos/stressCutscene.mp4', true);

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

		super.update(elapsed);
	}

	private function calcSize(Ind:Int):Float
	{
		var appliedWidth:Float = FlxG.stage.stageHeight * (FlxG.width / FlxG.height);
		var appliedHeight:Float = FlxG.stage.stageWidth * (FlxG.height / FlxG.width);

		if (appliedHeight > FlxG.stage.stageHeight)
			appliedHeight = FlxG.stage.stageHeight;

		if (appliedWidth > FlxG.stage.stageWidth)
			appliedWidth = FlxG.stage.stageWidth;

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
