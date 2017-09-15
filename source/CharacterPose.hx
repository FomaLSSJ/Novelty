package;

import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class CharacterPose extends FlxSprite
{
	public var pose:String;
	
	public function new(Pose:String, ?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset):Void
	{
		super(X, Y, SimpleGraphic);
		
		pose = Pose;
		visible = false;
	}
	
	public function setPosePosition(From:String=null, To:String=null, ?Callback:Void->Void):Void
	{
		if (From == null && To == null)
		{
			if (Callback != null)
			{
				Callback();
			}

			return;
		}
		
		var position:FlxPoint = null;
		var from:FlxPoint = getPosePosition(From);
		var to:FlxPoint = getPosePosition(To);

		if ((From != null && To == null) || (From == null && To != null))
		{
			position = getPosePosition((From != null && To == null) ? From : To);
		}
		
		setPosition((position != null) ? position.x : from.x, (position != null) ? position.y : from.y);
		
		if (position == null)
		{
			FlxTween.tween(this, {x: to.x, y: to.y}, 0.5, {type: FlxTween.ONESHOT, onComplete: function (tween:FlxTween):Void
			{
				if (Callback != null)
				{
					Callback();
				}
			}});
		}
		else
		{
			if (Callback != null)
			{
				Callback();
			}
		}
	}
	
	public function getPosePosition(Position:String=null):FlxPoint
	{
		var position:FlxPoint = new FlxPoint();
		
		switch (Position) 
		{
			case "outleft":
				position.set(this.width * -1, FlxG.height - this.height);
			case "left":
				position.set(0, FlxG.height - this.height);
			case "center":
				position.set(FlxG.width / 2 - this.width / 2, FlxG.height - this.height);
			case "right":
				position.set(FlxG.width - this.width, FlxG.height - this.height);
			case "outright":
				position.set(FlxG.width + this.width, FlxG.height - this.height);
			default:
				position.set(this.x, this.y);
		}
		
		return position;
	}
}