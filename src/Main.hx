package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import states.PlayState;

class Main extends Sprite
{
	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		addChild(new FlxGame(1280, 720, PlayState, Std.int(Lib.current.stage.frameRate), Std.int(Lib.current.stage.frameRate)));

		final zoom:Float = Math.min(Lib.current.stage.stageWidth / FlxG.stage.stageWidth, Lib.current.stage.stageHeight / FlxG.stage.stageHeight);
		addChild(new Overlay(10, 10, 15 * zoom)); // it's annoying to have it so small as to be unable to read it.
	}
}
