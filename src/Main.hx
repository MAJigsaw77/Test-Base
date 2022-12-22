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

		addChild(new FlxGame(game.width, game.height, game.main_state, Std.int(Lib.current.stage.frameRate), Std.int(Lib.current.stage.frameRate)));

		final zoom:Float = Math.min(Lib.current.stage.stageWidth / game.width, Lib.current.stage.stageHeight / game.height);
		addChild(new Overlay(10, 10, Std.int(game.overlay_size * zoom))); // it's annoying to have it so small as to be unable to read it.
	}
}
