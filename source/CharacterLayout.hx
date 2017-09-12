package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class CharacterLayout extends FlxTypedGroup<Dynamic>
{
	public function new(MaxSize:Int=0) 
	{
		super(MaxSize);
	}
	
	public function show():Void
	{
		var char:FlxSprite = new FlxSprite(0, 0, AssetPaths.hana_panty_smile__png);
		char.y = FlxG.height - char.height;
		
		add(char);
	}
	
	public function hide():Void
	{
		clear();
	}
}