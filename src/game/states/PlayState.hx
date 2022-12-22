package game.states;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		var bg:VideoHandler = new VideoHandler();
		bg.canSkip = false;
		bg.canUseAutoResize = false;
		bg.playVideo(SUtil.getStorageDirectory() + 'assets/videos/sarv.mp4', true);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
