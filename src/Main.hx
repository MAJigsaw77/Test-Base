package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import game.display.Overlay;
import game.states.PlayState;

class Main extends Sprite
{
	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		final framerate:Int = Std.int(Lib.current.stage.frameRate);
		addChild(new FlxGame(1280, 720, PlayState, framerate, framerate));

		addChild(new Overlay(10, 10, 1280, 720));
	}
}
