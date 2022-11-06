package;

#if android
import android.widget.Toast;
import lime.system.JNI;
#end
import flixel.FlxState;

class MainState extends FlxState
{
	override function create()
	{
		super.create();

		#if android
		Toast.makeText(getExternalFilesDir(null), Toast.LENGTH_LONG);
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	private function getExternalFilesDir(type:String = null):String
	{
		var getExternalFilesDir_jni:Dynamic = JNI.createStaticMethod("org/haxe/extension/Extension$mainContext", 'getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;');
		var getAbsolutePath_jni:Dynamic = JNI.createMemberMethod('java/io/File', 'getAbsolutePath', '()Ljava/lang/String;');
		return getAbsolutePath_jni(getExternalFilesDir_jni(type));
	}
}
