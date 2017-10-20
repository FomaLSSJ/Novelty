package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class BackgroundLayout extends FlxTypedGroup<Dynamic>
{
	public var backgroundGroup:FlxTypedGroup<Background>;
	
	private var backgrounds:Map<String, Dynamic>;
	
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
		backgrounds = Reg.backgrounds;
		backgroundGroup = new FlxTypedGroup<Background>();
		
		if (exists == false)
		{
			revive();
		}
		
		add(backgroundGroup);
	}
	
	public function append(Key:String, Bg:Background):Void
	{
		backgrounds.set(Key, Bg);
		
		backgroundGroup.add(Bg);
	}
	
	public function setBackground(name:String = null):Void
	{
		if (name != null)
		{
			backgroundGroup.forEach( function (Bg:Background):Void
			{
				if (name == Bg.name)
				{
					Bg.visible = true;
				}
				else
				{
					Bg.visible = false;
				}
			});
		}
	}
	
	public function removeBackground():Void
	{
		backgroundGroup.forEach(function (Bg:Background):Void
		{
			Bg.visible = false;
		});
	}
}