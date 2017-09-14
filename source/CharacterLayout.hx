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
		
		var char:FlxSprite = new FlxSprite(0, 0, AssetPaths.hana_panty_smile__png);
		char.visible = false;
		
		add(char);
	}
	
	public function show(Who:String, Pose:String, From:String, ?To:String):Void
	{
		if (characters.exists(Who) && characters.get(Who).exists(Pose))
		{
			var who:Character = characters.get(Who);
			var pose:FlxSprite = who.get(Pose);
			var from:FlxPoint = Character.getPosition(pose, From);
			var to:FlxPoint = Character.getPosition(pose, To);
			
			pose.alive = true;
			pose.setPosition(from.x, from.y);
		
			Reg.character.add(pose);
			
			FlxTween.tween(pose, {x: to.x, y: to.y}, 0.5, {type: FlxTween.ONESHOT});
		}
		else
		{
			trace("Not exist " + Who + " or type " + Type + ".");
			return;
		}
	}
	
	public function hide(Who:String, ?To:String):Void
	{
		if (characters.exists(Who))
		{
			var who:Character = characters.get(Who);
			var to:FlxPoint = Character.getPosition("outleft");
			
			FlxTween.tween(who, {x: to.x, y: to.y}, 0.5, {type: FlxTween.ONESHOT, onComplete: function (tween:FlxTween):Void
			{
				for (x in who)
				{
					if (Std.is(x, FlxSprite) && x.alive == true)
					{
						x.alive = false;
						Reg.character.remove(x);
					}
				}
			}});
		}
		else
		{
			trace("Not exist " + Who + " or type " + Type + ".");
			return;
		}
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
		return (characters.exists(Key)) ? characters.get(Key).get("name") : Key;
	}
}