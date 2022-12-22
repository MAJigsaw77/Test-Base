package;

#if android
import android.os.Build.VERSION;
#end
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
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var currentMemoryPeak:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float, y:Float)
	{
		super();

		this.x = x;
		this.y = x;
		this.autoSize = LEFT;
		this.selectable = false;
		this.mouseEnabled = false;
		this.defaultTextFormat = new TextFormat('_sans', 15, 0xFFFFFF);

		currentTime = 0;
		currentMemoryPeak = 0;
		times = [];

		addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var time:Int = Lib.getTimer();
			onEnterFrame(time - currentTime);
		});
	}

	private function onEnterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
			times.shift();

		var currentFrames:Int = times.length;
		if (currentFrames > Std.int(Lib.current.stage.frameRate))
			currentFrames = Std.int(Lib.current.stage.frameRate);

		if (currentFrames <= Std.int(Lib.current.stage.frameRate) / 4)
			textColor = 0xFFFF0000;
		else if (currentFrames <= Std.int(Lib.current.stage.frameRate) / 2)
			textColor = 0xFFFFFF00;
		else
			textColor = 0xFFFFFFFF;

		var currentMemory:Float = System.totalMemory;
		if (currentMemory > currentMemoryPeak)
			currentMemoryPeak = currentMemory;

		if (visible || alpha > 0)
		{
			var stats:Array<String> = [];
			stats.push('FPS: ${currentFrames}');
			stats.push('Memory: ${getMemoryInterval(currentMemory)} / ${getMemoryInterval(currentMemoryPeak)}');
			stats.push('GL Renderer: ${getGLInfo(RENDERER)}');
			stats.push('GL Shading Version: ${getGLInfo(SHADING_LANGUAGE_VERSION)}');
			#if android
			stats.push('OS: Android ${VERSION.RELEASE} (API ${VERSION.SDK_INT})');
			#else
			stats.push('OS: ${lime.system.System.platformLabel} ${lime.system.System.platformVersion}');
			#end
			stats.push('');
			text = stats.join('\n');
		}
	}

	private function getMemoryInterval(size:Float):String
	{
		var data:Int = 0;

		final intervalArray:Array<String> = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
		while (size >= 1000 && data < intervalArray.length - 1)
		{
			data++;
			size = size / 1000;
		}

		size = Math.round(size * 100) / 100;
		return size + ' ' + intervalArray[data];
	}

	private function getGLInfo(info:GPUInfo):String
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

		return '';
	}
}
