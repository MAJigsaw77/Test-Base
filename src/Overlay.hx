package;

import haxe.Timer;
import openfl.Lib;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

#if windows
@:headerCode("
#include <windows.h>
#include <psapi.h>
")
#elseif mac
@:headerCode("
#include <unistd.h>
#include <sys/resource.h>
#include <mach/mach.h>
") 
#elseif (linux || android)
@:headerCode("
#include <unistd.h>
#include <sys/resource.h>
#include <stdio.h>
")
#end
class Overlay extends TextField
{
	private var times:Array<Float> = [];
	private var totalMemoryPeak:Float = 0;

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

			#if (desktop || android)
			var totalMemory:Float = Std.parseFloat(getCurrentUsage());
			#else
			var totalMemory:Float = System.totalMemory;
			#end

			if (totalMemory > totalMemoryPeak)
				totalMemoryPeak = totalMemory;

			if (visible)
				text = currentFrames + ' FPS\n' + getInterval(totalMemory) + ' / ' + getInterval(totalMemoryPeak) + '\n';
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

	/**
 	 * Returns the current resident set size (physical memory use) measured
 	 * in bytes, or 0 if the value cannot be determined on this OS.
	 */
	#if windows
	@:functionCode("
		PROCESS_MEMORY_COUNTERS info;
		GetProcessMemoryInfo(GetCurrentProcess(), &info, sizeof(info));
		return (size_t)info.WorkingSetSize;
	")
	#elseif mac
	@:functionCode("
    		struct mach_task_basic_info info;
		mach_msg_type_number_t infoCount = MACH_TASK_BASIC_INFO_COUNT;
		if (task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &infoCount) != KERN_SUCCESS)
			return (size_t)0L;

		return (size_t)info.resident_size;
	")
	#elseif (linux || android)
	@:functionCode('
		long rss = 0L;
		FILE* fp = NULL;

		if ((fp = fopen("/proc/self/statm", "r")) == NULL)
			return (size_t)0L;

		if (fscanf(fp, "%*s%ld", &rss) != 1)
		{
			fclose(fp);
			return (size_t)0L;
		}

		fclose(fp);
		return (size_t)rss * (size_t)sysconf( _SC_PAGESIZE);
	')
	#end
	private function getCurrentUsage():Dynamic
		return 0;
}
