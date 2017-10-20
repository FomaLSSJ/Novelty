package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Background extends FlxSprite 
{
	public var name:String = null;
	
	public function new(Name:String, ?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset):Void
	{
		super(X, Y, SimpleGraphic);
		
		name = Name;
		
		visible = false;
	}
}