package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Character extends FlxTypedGroup<Dynamic>
{
	public var id:String;
	public var name:String;
	
	override public function new(Id:String, Name:String, ?MaxSize:Int=0):Void
	{
		super(MaxSize);
		
		id = Id;
		name = Name;
	}
	
	public function addSprite(Pose:String, Sprite:FlxGraphicAsset):Void
	{
		var sprite:CharacterPose = new CharacterPose(Pose, Sprite);
		
		add(sprite);
	}
	
	public function showSprite(Pose:String, ?From:String=null, ?To:String=null):Void
	{
		forEach(function (sprite:CharacterPose):Void
		{
			if (sprite.pose == Pose)
			{
				sprite.visible = true;
				sprite.setPosePosition(From, To);
			}
		});
	}
	
	public function hideSprite(?To:String=null):Void
	{
		forEach(function (sprite:CharacterPose):Void
		{
			if (sprite.visible == true)
			{
				sprite.setPosePosition("default", To, function ():Void
				{
					sprite.visible = false;
				});
			}
		});
	}
	
	public function getSprite():CharacterPose
	{
		var result:CharacterPose = null;
		
		forEach(function (sprite:CharacterPose):Void
		{
			if (sprite.visible == true)
			{
				result = sprite;
			}
		});
		
		return result;
	}
}