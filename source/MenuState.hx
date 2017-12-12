package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState 
{
	private var buttonNewGame:FlxButton;
	private var buttonLoadGame:FlxButton;
	private var buttonOptions:FlxButton;
	private var buttonExit:FlxButton;
	
	override public function create():Void
	{
		buttonNewGame = new FlxButton(0, 0, "New Game", onClickPlay);
		buttonNewGame.setPosition(FlxG.width / 2 - buttonNewGame.width / 2, FlxG.height / 2);
		
		add(buttonNewGame);
		
		buttonLoadGame = new FlxButton(0, 0, "Load Game", onClickLoad);
		buttonLoadGame.setPosition(FlxG.width / 2 - buttonNewGame.width / 2, FlxG.height / 2 + 40);
		
		add(buttonLoadGame);
		
		buttonOptions = new FlxButton(0, 0, "Options", onClickOptions);
		buttonOptions.setPosition(FlxG.width / 2 - buttonNewGame.width / 2, FlxG.height / 2 + 80);
		
		add(buttonOptions);
		
		#if (neko || windows)
		buttonExit = new FlxButton(0, 0, "Exit", onClickExit);
		buttonExit.setPosition(FlxG.width / 2 - buttonNewGame.width / 2, FlxG.height / 2 + 120);
		
		add(buttonExit);
		#end
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	private function onClickPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	private function onClickLoad():Void
	{
		FlxG.switchState(new PlayState(true));
	}
	
	private function onClickOptions():Void
	{
		FlxG.switchState(new OptionState());
	}
	
	#if (neko || windows)
	private function onClickExit():Void
	{
		Sys.exit(1);
	}
	#end
}