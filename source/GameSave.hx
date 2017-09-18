package;

import flixel.FlxSprite;
import flixel.util.FlxSave;

class GameSave extends FlxSave
{
	public function new():Void
	{
		super();
	}
	
	public function getBackgroundData():Dynamic
	{
		var bg:BackgroundLayout = Reg.background;
		var result:Map<String, String>;
		
		bg.backgroundGroup.forEach(function (x:FlxSprite):Void
		{
			result = ["key" => "background", "sprite" => AssetPaths.background__png];
			return;
		});
		
		return result;
	}
	
	public function getCharactersData():Dynamic
	{
		var result:Array<Dynamic> = new Array<Dynamic>();
		var chars:Map<String, Character> = Reg.characters;
		
		for (char in chars)
		{
			var sprite:CharacterPose = char.getSprite();
			
			if (sprite != null)
			{
				result.push({id: char.id, pose: sprite.pose, coord: sprite.coord});
			}
		}
		
		return result;
	}
}