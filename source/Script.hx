package;

import haxe.Json;
#if neko
import sys.io.File;
#end

class Script
{
	macro public static function json(path:String)
	{
		#if neko
		var value = File.getContent(path);
		#end
			
		var json = Json.parse(value);
		
		return macro $v{json};
	}
}