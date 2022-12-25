package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;
import game.display.Overlay;
import game.states.PlayState;

class Main extends Sprite
{
	var game:Dynamic = {
		width: 1280,
		height: 720,
		main_state: PlayState,
		overlay_size: 15
	};

	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		final framerate:Int = Std.int(Lib.current.stage.frameRate);
		addChild(new FlxGame(game.width, game.height, game.main_state, framerate, framerate));
		addChild(new Overlay(10, 10)); // it's annoying to have it so small as to be unable to read it.
	}
}
