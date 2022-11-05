package;

import haxe.Timer;
import memory.Memory;
import openfl.Lib;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class Overlay extends TextField
{
	private var times:Array<Float> = [];

	public function new(x:Float, y:Float, color:Int)
	{
		super();

		this.x = x;
		this.y = x;
		this.autoSize = LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		this.defaultTextFormat = new TextFormat('_sans', 14, 0xFFFFFF);

		addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var now = Timer.stamp();
			times.push(now);
			while (times[0] < now - 1)
				times.shift();

			final frameRate:Int = Std.int(Lib.current.stage.frameRate);
			var currentFrames:Int = times.length;
			if (currentFrames > frameRate)
				currentFrames = frameRate;

			if (currentFrames <= frameRate / 4)
				textColor = 0xFFFF0000;
			else if (currentFrames <= frameRate / 2)
				textColor = 0xFFFFFF00;
			else
				textColor = 0xFFFFFFFF;

			if (visible)
				text = currentFrames + ' FPS\n' + getInterval(Std.float(Memory.getCurrentUsage())) + ' / ' + getInterval(Std.float(Memory.getPeakUsage())) + '\n';
		});
	}

	private function getInterval(size:Float):String
	{
		var data:Int = 0;

		final intervalArray:Array<String> = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
		while (size > 1024 && data < intervalArray.length - 1)
		{
			data++;
			size = size / 1024;
		}

		size = Math.round(size * 100) / 100;
		return size + ' ' + intervalArray[data];
	}
}
