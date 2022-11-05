package memory;

/**
 * Memory class to properly get accurate memory counts
 * for the program.
 * @author Mihai Alexandru (M.A. Jigsaw) - David Robert Nadeau (Original C Header)
 */
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
class Memory
{
	/**
	 * Returns the peak (maximum so far) resident set size (physical
	 * memory use) measured in bytes, or zero if the value cannot be
	 * determined on this OS.
	 */
	#if windows
	@:functionCode("
		PROCESS_MEMORY_COUNTERS info;
		GetProcessMemoryInfo(GetCurrentProcess(), &info, sizeof(info));
		return (size_t)info.PeakWorkingSetSize;
	")
	#elseif (mac || linux || android) 
	@:functionCode("
		struct rusage usage;
		getrusage(RUSAGE_SELF, &usage);
		return (size_t)usage.ru_maxrss;
	")
	#end
	public static function getPeakUsage():Dynamic
		return 0;

	/**
 	 * Returns the current resident set size (physical memory use) measured
 	 * in bytes, or zero if the value cannot be determined on this OS.
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
	public static function getCurrentUsage():Dynamic
		return 0;
}
