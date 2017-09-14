package;

import haxe.ds.ObjectMap;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

//TODO Переделать в FlxTypedGroup<FlxSprite>
class Character extends ObjectMap<String, Dynamic>
{
	override public function new(Name:String):Void
	{
		super();
		
		this.set("name", Name);
	}
	
	public function addSprite(Key:String, Sprite:FlxGraphicAsset):Void
	{
		var sprite:FlxSprite = new FlxSprite(Sprite);
		sprite.alive = false;
		
		this.set(Key, sprite);
	}
	
	static public function getPosition(?Sprite:FlxSprite, ?Position:String):FlxPoint
	{
		var position:FlxPoint = new FlxPoint();

		switch (Position) 
		{
			case "outleft":
				position.set(
					(Sprite != null) ? Sprite.width * -1 : -200,
					(Sprite != null) ? FlxG.height - Sprite.height : FlxG.height - 320
				);
			default:
				position.set();
		}

		return position;
	}
}