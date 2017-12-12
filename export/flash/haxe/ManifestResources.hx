package;


import lime.app.Config;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Config):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_ag_helvetica_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_helios_cond_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_roboto_condensed_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_roboto_thin_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end
		
		var data, manifest, library;
		
		data = '{"name":null,"assets":"aoy4:sizei32904y4:typey4:FONTy9:classNamey37:__ASSET__assets_data_ag_helvetica_ttfy2:idy32:assets%2Fdata%2Fag-helvetica.ttfgoR0zR1y4:TEXTR3y39:__ASSET__assets_data_data_goes_here_txtR5y34:assets%2Fdata%2Fdata-goes-here.txtgoR0i37940R1R2R3y36:__ASSET__assets_data_helios_cond_ttfR5y31:assets%2Fdata%2Fhelios-cond.ttfgoR0i156184R1R2R3y41:__ASSET__assets_data_roboto_condensed_ttfR5y36:assets%2Fdata%2Froboto-condensed.ttfgoR0i118840R1R2R3y36:__ASSET__assets_data_roboto_thin_ttfR5y31:assets%2Fdata%2Froboto-thin.ttfgoR0i848R1R7R3y32:__ASSET__assets_data_script_jsonR5y27:assets%2Fdata%2Fscript.jsongoR0i594339R1y5:IMAGER3y37:__ASSET__assets_images_background_pngR5y32:assets%2Fimages%2Fbackground.pnggoR0i63185R1R18R3y43:__ASSET__assets_images_hana_panty_smile_pngR5y38:assets%2Fimages%2Fhana_panty_smile.pnggoR0i62881R1R18R3y47:__ASSET__assets_images_hana_school_confused_pngR5y42:assets%2Fimages%2Fhana_school_confused.pnggoR0zR1R7R3y41:__ASSET__assets_images_images_go_here_txtR5y36:assets%2Fimages%2Fimages-go-here.txtgoR0i386149R1R18R3y32:__ASSET__assets_images_night_pngR5y27:assets%2Fimages%2Fnight.pnggoR0zR1R7R3y41:__ASSET__assets_music_music_goes_here_txtR5y36:assets%2Fmusic%2Fmusic-goes-here.txtgoR0zR1R7R3y41:__ASSET__assets_sounds_sounds_go_here_txtR5y36:assets%2Fsounds%2Fsounds-go-here.txtgoR0i2114R1y5:MUSICR3y31:__ASSET__flixel_sounds_beep_mp3R5y26:flixel%2Fsounds%2Fbeep.mp3goR0i39706R1R33R3y33:__ASSET__flixel_sounds_flixel_mp3R5y28:flixel%2Fsounds%2Fflixel.mp3goR0i16272R1R2R3y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfgoR0i29724R1R2R3y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfgoR0i519R1R18R3y36:__ASSET__flixel_images_ui_button_pngR5y33:flixel%2Fimages%2Fui%2Fbutton.pnggoR0i3280R1R18R3y39:__ASSET__flixel_images_logo_default_pngR5y36:flixel%2Fimages%2Flogo%2Fdefault.pnggh","version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_ag_helvetica_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_data_helios_cond_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_data_roboto_condensed_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_data_roboto_thin_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__assets_data_script_json extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hana_panty_smile_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_hana_school_confused_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_images_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_images_night_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends flash.utils.ByteArray { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends flash.media.Sound { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends flash.text.Font { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends flash.utils.ByteArray { }


#elseif (desktop || cpp)

@:font("assets/data/ag-helvetica.ttf") #if display private #end class __ASSET__assets_data_ag_helvetica_ttf extends lime.text.Font {}
@:file("assets/data/data-goes-here.txt") #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:font("assets/data/helios-cond.ttf") #if display private #end class __ASSET__assets_data_helios_cond_ttf extends lime.text.Font {}
@:font("assets/data/roboto-condensed.ttf") #if display private #end class __ASSET__assets_data_roboto_condensed_ttf extends lime.text.Font {}
@:font("assets/data/roboto-thin.ttf") #if display private #end class __ASSET__assets_data_roboto_thin_ttf extends lime.text.Font {}
@:file("assets/data/script.json") #if display private #end class __ASSET__assets_data_script_json extends haxe.io.Bytes {}
@:image("assets/images/background.png") #if display private #end class __ASSET__assets_images_background_png extends lime.graphics.Image {}
@:image("assets/images/hana_panty_smile.png") #if display private #end class __ASSET__assets_images_hana_panty_smile_png extends lime.graphics.Image {}
@:image("assets/images/hana_school_confused.png") #if display private #end class __ASSET__assets_images_hana_school_confused_png extends lime.graphics.Image {}
@:file("assets/images/images-go-here.txt") #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:image("assets/images/night.png") #if display private #end class __ASSET__assets_images_night_png extends lime.graphics.Image {}
@:file("assets/music/music-goes-here.txt") #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:file("assets/sounds/sounds-go-here.txt") #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:file("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:font("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/fonts/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:image("C:/HaxeToolkit/haxe/lib/flixel/4,3,0/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_data_ag_helvetica_ttf') #if display private #end class __ASSET__assets_data_ag_helvetica_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/ag-helvetica.ttf"; #end name = "AG_Helvetica"; super (); }}
@:keep @:expose('__ASSET__assets_data_helios_cond_ttf') #if display private #end class __ASSET__assets_data_helios_cond_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/helios-cond.ttf"; #end name = "Helios Cond Light"; super (); }}
@:keep @:expose('__ASSET__assets_data_roboto_condensed_ttf') #if display private #end class __ASSET__assets_data_roboto_condensed_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/roboto-condensed.ttf"; #end name = "Roboto Condensed"; super (); }}
@:keep @:expose('__ASSET__assets_data_roboto_thin_ttf') #if display private #end class __ASSET__assets_data_roboto_thin_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/roboto-thin.ttf"; #end name = "Roboto Thin"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

@:keep @:expose('__ASSET__OPENFL__assets_data_ag_helvetica_ttf') #if display private #end class __ASSET__OPENFL__assets_data_ag_helvetica_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_data_ag_helvetica_ttf (); src = font.src; name = font.name; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_data_helios_cond_ttf') #if display private #end class __ASSET__OPENFL__assets_data_helios_cond_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_data_helios_cond_ttf (); src = font.src; name = font.name; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_data_roboto_condensed_ttf') #if display private #end class __ASSET__OPENFL__assets_data_roboto_condensed_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_data_roboto_condensed_ttf (); src = font.src; name = font.name; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_data_roboto_thin_ttf') #if display private #end class __ASSET__OPENFL__assets_data_roboto_thin_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__assets_data_roboto_thin_ttf (); src = font.src; name = font.name; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_nokiafc22_ttf (); src = font.src; name = font.name; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { var font = new __ASSET__flixel_fonts_monsterrat_ttf (); src = font.src; name = font.name; super (); }}


#end
#end