package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		final width:Int = Math.ceil(Lib.current.stage.stageWidth / zoom);
		final height:Int = Math.ceil(Lib.current.stage.stageHeight / zoom);
		final framerate:Int = Std.int(Lib.current.stage.frameRate);

		addChild(new FlxGame(width, height, MainState, framerate, framerate, false, false));
		addChild(new Overlay(10, 10, 0xFFFFFF));
	}
}
