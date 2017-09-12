package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState 
{
	private var buttonNewGame:FlxButton;
	
	override public function create():Void
	{
		buttonNewGame = new FlxButton(0, 0, "New Game", onPlay);
		buttonNewGame.setPosition(FlxG.width / 2 - buttonNewGame.width / 2, FlxG.height / 2);
		
		add(buttonNewGame);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function onPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
}