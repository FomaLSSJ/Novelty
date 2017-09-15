package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

class CharacterLayout extends FlxTypedGroup<Dynamic>
{
	private var characters:Map<String, Character>;
	
	public function new(MaxSize:Int=0):Void
	{
		super(MaxSize);
	}
	
	public function init():Void
	{
		characters = new Map<String, Character>();
	}
	
	public function append(Key:String, Char:Character):Void
	{
		characters.set(Key, Char);
		
		add(Char);
	}
	
	public function show(Who:String, Pose:String, From:String, ?To:String):Void
	{
		var who:Character = characters.get(Who);
		who.showSprite(Pose, From, To);
	}
	
	public function hide(Who:String, ?To:String):Void
	{
		var who:Character = characters.get(Who);
		who.hideSprite(To);
	}
	
	public function move():Void
	{
		var char:FlxSprite = getFirstExisting();
		
		FlxTween.linearMotion(char, char.x, char.y, FlxG.width - char.width, char.y);
	}
	
	public function getCharacters():Map<String, Character>
	{
		return characters;
	}
	
	public function say(Key:String):String
	{
		return (characters.exists(Key)) ? characters.get(Key).name : Key;
	}
}