package;

class Reg 
{
	public static var objectSave:String = "Novelty";
	public static var gameSave:GameSave = new GameSave();
	
	public static var enabledSkip:Bool = false;
	public static var textSpeed:Float = 0;
	
	public static var currentScene:Dynamic = {};
	public static var currentChars:Array<Dynamic> = [];
	public static var currentScriptIndex:Int = 0;
	
	public static var characters:Map<String, Character> = new Map<String, Character>();
	public static var backgrounds:Map<String, Background> = new Map<String, Background>();
	
	public static var background:BackgroundLayout = new BackgroundLayout();
	public static var character:CharacterLayout = new CharacterLayout();
	public static var dialogBox:DialogBox = new DialogBox();
	public static var effect:EffectLayout = new EffectLayout();
}