package;

#if android
import android.os.Build.VERSION;
#end
import haxe.Timer;
import openfl.Lib;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

class Overlay extends TextField
{
	private var times:Array<Float> = [];
	private var totalMemoryPeak:Float = 0;
	private var totalGPUMemoryPeak:Float = 0;

	public function new(x:Float, y:Float)
	{
		super();

		this.x = x;
		this.y = x;
		this.autoSize = LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		this.defaultTextFormat = new TextFormat('_sans', 15, 0xFFFFFF);

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

			var totalMemory:Float = System.totalMemory;
			if (totalMemory > totalMemoryPeak)
				totalMemoryPeak = totalMemory;

			var totalGPUMemory:Float = Lib.current.stage.context3D.totalGPUMemory;
			if (totalGPUMemory > totalGPUMemoryPeak)
				totalGPUMemoryPeak = totalGPUMemory;

			if (visible)
			{
				var text:Array<String> = [];
				text.push('FPS: ${currentFrames}');
				text.push('RAM: ${getInterval(totalMemory)} / ${getInterval(totalMemoryPeak)}');
				text.push('GPU: ${getInterval(totalGPUMemory)} / ${getInterval(totalGPUMemoryPeak)}');
				text.push('GPU Driver: ${Lib.current.stage.context3D.driverInfo}');
				#if android
				text.push('System: ${VERSION.RELEASE} (API ${VERSION.SDK_INT})');
				#else
				text.push('System: ${lime.system.System.platformLabel} ${lime.system.System.platformVersion}');
				#end
				this.text = text.join('\n') + '\n';
			}
		});
	}

	private function getInterval(size:Float):String
	{
		var data:Int = 0;

		final intervalArray:Array<String> = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
		while (size >= 1024 && data < intervalArray.length - 1)
		{
			data++;
			size = size / 1024;
		}

		size = Math.round(size * 100) / 100;
		return size + ' ' + intervalArray[data];
	}
}
