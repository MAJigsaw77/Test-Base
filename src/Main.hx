package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		final zoom:Float = Math.min(Lib.current.stage.stageWidth / Lib.application.window.width, Lib.current.stage.stageHeight / Lib.application.window.height);

		addChild(new FlxGame(Math.ceil(Lib.current.stage.stageWidth / zoom), Math.ceil(Lib.current.stage.stageHeight / zoom), MainState, zoom, 60, 60, false, false));
		addChild(new FPS(10, 10, 0xFFFFFF));
	}
}
