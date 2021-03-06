package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup.FlxTypedGroup;
import haxe.Timer;

class EffectLayout extends FlxTypedGroup<Dynamic>
{
	private var dialogBox:DialogBox = Reg.dialogBox;
	private var toBeContinue:FlxSprite;
	
	override public function new(MaxSize:Int=0):Void
	{
		super(MaxSize);
	}
	
	override public function destroy():Void
	{
		trace("EffectLayout destroy");
		kill();
	}
	
	public function init():Void
	{
		toBeContinue = new FlxSprite(0, 0, AssetPaths.to_be_continued__png);
		toBeContinue.setPosition(toBeContinue.width * -1, FlxG.height - toBeContinue.height);
		
		if (exists == false)
		{
			revive();
		}
		
		add(toBeContinue);
	}
	
	public function start(?Delay:Int=1, ?Callback:Void->Void):Void
	{
		Reg.mode = Reg.GAME_MODE.EFFECT;
		dialogBox.active = dialogBox.visible = false;

		FlxTween.tween(toBeContinue,
			{ x: FlxG.width - (toBeContinue.width + 10), y: toBeContinue.y }, 0.5,
			{type: FlxTween.ONESHOT, onComplete: function (tween:FlxTween):Void
			{
				if (Callback != null)
				{
					Timer.delay(function ():Void
					{
						Reg.mode = Reg.GAME_MODE.NORMAL;
						dialogBox.active = dialogBox.visible = true;
						Callback();
					}, Delay * 1000);
				}
				else
				{
					Reg.mode = Reg.GAME_MODE.NORMAL;
					dialogBox.active = dialogBox.visible = true;
				}
			}});
	}
	
	public function reset():Void
	{
		if (toBeContinue != null)
		{
			Reg.mode = Reg.GAME_MODE.NORMAL;
			toBeContinue.setPosition(toBeContinue.width * -1, FlxG.height - toBeContinue.height);
		}
	}
}