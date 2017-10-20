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
		var result:Dynamic = {};
		var bgs:Map<String, Background> = Reg.backgrounds;
		
		for (bg in bgs)
		{
			if (bg.visible == true)
			{
				result = {background: bg.name};
			}
		}
		
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