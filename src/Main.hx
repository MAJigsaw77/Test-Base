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

		final zoom:Float = Math.min(Lib.current.stage.stageWidth / Lib.application.window.width, Lib.current.stage.stageHeight / Lib.application.window.height);

		addChild(new FlxGame(Math.ceil(Lib.current.stage.stageWidth / zoom), Math.ceil(Lib.current.stage.stageHeight / zoom), MainState, zoom, Std.int(Lib.current.stage.frameRate), Std.int(Lib.current.stage.frameRate), false, false));
		addChild(new Overlay(10, 10, 0xFFFFFF));
	}
}
