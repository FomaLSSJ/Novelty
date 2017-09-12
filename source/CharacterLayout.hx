package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

class CharacterLayout extends FlxTypedGroup<Dynamic>
{
	public function new(MaxSize:Int=0):Void
	{
		super(MaxSize);
	}
	
	public function init():Void
	{
		var char:FlxSprite = new FlxSprite(0, 0, AssetPaths.hana_panty_smile__png);
		char.visible = false;
		
		add(char);
	}
	
	public function show(from:FlxPoint, to:FlxPoint):Void
	{
		var char:FlxSprite = getFirstExisting();
		
		char.setPosition(from.x, from.y);
		char.visible = true;
		
		FlxTween.tween(char, {x: to.x, y: to.y}, 0.5, {type: FlxTween.ONESHOT});
	}
	
	public function hide(to:FlxPoint):Void
	{
		var char:FlxSprite = getFirstExisting();
		
		FlxTween.tween(char, {x: to.x, y: to.y}, 0.5, {type: FlxTween.ONESHOT, onComplete: function (tween:FlxTween):Void
		{
			char.visible = false;
		}});
	}
	
	public function move():Void
	{
		var char:FlxSprite = getFirstExisting();
		
		FlxTween.linearMotion(char, char.x, char.y, FlxG.width - char.width, char.y);
	}
}