package;

import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();

		SUtil.uncaughtErrorHandler();
		SUtil.checkPermissions();

		addChild(new Overlay(10, 10));
	}
}
