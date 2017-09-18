package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class BackgroundLayout extends FlxTypedGroup<Dynamic>
{
	public var backgroundGroup:FlxTypedGroup<FlxSprite>;
	
	public function new(MaxSize:Int = 0):Void
	{
		super(MaxSize);
	}
	
	override public function destroy():Void
	{
		trace("BackgroundLayout destroy");
		backgroundGroup.clear();
		kill();
	}
	
	public function init():Void
	{
		backgroundGroup = new FlxTypedGroup<FlxSprite>();
		
		if (exists == false)
		{
			revive();
		}
		
		add(backgroundGroup);
	}
	
	public function setBackground(image:Dynamic = null):Void
	{
		if (image != null)
		{
			removeBackground();
			backgroundGroup.add(new FlxSprite(0, 0, image));
		}
	}
	
	public function removeBackground():Void
	{
		backgroundGroup.clear();
	}
}