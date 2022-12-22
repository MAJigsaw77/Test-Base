package game.states;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		var bg:VideoSprite = new VideoSprite();
		bg.bitmap.canSkip = false;
		bg.bitmap.canUseAutoResize = false;
		bg.playVideo(SUtil.getStorageDirectory() + 'assets/videos/sarv.mp4', true);
		add(bg);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
