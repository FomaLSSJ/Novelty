package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class BackgroundLayout extends FlxTypedGroup<Dynamic>
{
	private var backgroundGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	
	override public function new(MaxSize:Int = 0):Void
	{
		super(MaxSize);
		
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
		backgroundGroup.forEach(function(i)
		{
			trace(i);
		});
		
		backgroundGroup.clear();
	}
	
}