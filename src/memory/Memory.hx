package memory;

/**
 * Memory class to properly get accurate memory counts
 * for the program.
 * @author Leather128 (Haxe) - David Robert Nadeau (Original C Header)
 */
@:buildXml('
	<files id="haxe">
		<compilervalue name="-I" value="${this_dir}/include/" />
	</files>
')
@:include("memory.h")
extern class Memory
{
	/**
	 * Returns the peak (maximum so far) resident set size (physical
	 * memory use) measured in bytes, or zero if the value cannot be
	 * determined on this OS.
	 */
	@:native("getPeakRSS")
	public static function getPeakUsage():Int;

	/**
 	 * Returns the current resident set size (physical memory use) measured
 	 * in bytes, or zero if the value cannot be determined on this OS.
	 */
	@:native("getCurrentRSS")
	public static function getCurrentUsage():Int;
}
