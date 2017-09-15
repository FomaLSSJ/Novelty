package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.ui.FlxButton;

class OptionState extends FlxState 
{
	private var buttonBack:FlxButton;
	
	override public function create():Void
	{
		buttonBack = new FlxButton(0, 0, "<- Back", onBack);
		buttonBack.setPosition(32, FlxG.height - 64);
		
		add(buttonBack);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function onBack():Void
	{
		FlxG.switchState(new MenuState());
	}
}