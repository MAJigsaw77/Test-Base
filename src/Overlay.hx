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

enum GPUInfo
{
	RENDERER;
	SHADING_LANGUAGE_VERSION;
}

class Overlay extends TextField
{
	private var times:Array<Float> = [];
	private var totalMemoryPeak:Float = 0;

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

			if (visible)
			{
				var text:Array<String> = [];
				text.push('FPS: ${currentFrames}');
				text.push('Memory: ${getInterval(totalMemory)} / ${getInterval(totalMemoryPeak)}');
				text.push('GL Renderer: ${getInfo(RENDERER)}');
				text.push('GL Shading Version: ${getInfo(SHADING_LANGUAGE_VERSION)}');
				#if android
				text.push('System: Android ${VERSION.RELEASE} (API ${VERSION.SDK_INT})');
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

	private function getInfo(info:GPUInfo):String
	{
		@:privateAccess
		var gl:Dynamic = Lib.current.stage.context3D.gl;

		switch (info)
		{
			case RENDERER:
				return Std.string(gl.getParameter(gl.RENDERER));
			case SHADING_LANGUAGE_VERSION:
				return Std.string(gl.getParameter(gl.SHADING_LANGUAGE_VERSION));
		}

		return null;
	}
}

