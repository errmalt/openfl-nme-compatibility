package nme;
#if display


extern class Loader
{
	static function load(func:String, args:Int):Dynamic;
	static function loaderTrace(inStr:String):Void;
	static function tryLoad(inName:String, func:String, args:Int):Dynamic;
}


#elseif (cpp || neko)


class Loader {
	
	
	public static function load (func:String, args:Int):Dynamic {
		
		return flash.Lib.load ("nme", func, args);
		
	}
	
	
	public static function loaderTrace (inStr:String):Void {
		
		// Problems with initialization order in cpp...
		#if cpp
		var get_env = cpp.Lib.load ("std", "get_env", 1);
		var debug = (get_env ("NME_LOAD_DEBUG") != null);
		#else
		var debug = (Sys.getEnv ("NME_LOAD_DEBUG") != null);
		#end
		
		if (debug) {
			
			Sys.println (inStr);
			
		}
		
	}
	
	
	public static function tryLoad (inName:String, func:String, args:Int):Dynamic {
		
		/*try {
			
			var result =  Lib.load(inName, func, args);

			if (result != null) {
				
				loaderTrace("Got result " + inName);
				moduleName = inName;
				return result;
				
			}

		} catch(e:Dynamic) {
			
			loaderTrace ("Failed to load : " + inName);
			
		}
		
		return null;*/
		
		return flash.Lib.load (inName, func, args);
		
	}
	
	
}


#end
