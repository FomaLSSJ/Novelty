package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class OptionState extends FlxState 
{
	private var gameSave:GameSave = Reg.gameSave;
	
	private var buttonBack:FlxButton;
	
	private var buttonEnabledSkip:FlxButton;
	private var textEnabledSkip:FlxText;
	
	override public function create():Void
	{
		gameSave.bind(Reg.objectSave);
		Reg.enabledSkip = (gameSave.data.enabledSkip == true) ? true : false;
		gameSave.close();
		
		buttonBack = new FlxButton(0, 0, "<- Back", onClickBack);
		buttonBack.setPosition(32, FlxG.height - 64);
		
		add(buttonBack);
		
		buttonEnabledSkip = new FlxButton(0, 0, "Change Skip", onClickEnabledSkip);
		buttonEnabledSkip.setPosition(FlxG.width / 4 - buttonEnabledSkip.width / 2, FlxG.height / 2);
		
		add(buttonEnabledSkip);
		
		textEnabledSkip = new FlxText(0, 0, 0, "...");
		textEnabledSkip.setPosition(FlxG.width / 1.5 - textEnabledSkip.width / 2, FlxG.height / 2);
		
		add(textEnabledSkip);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		textEnabledSkip.text = (Reg.enabledSkip == true) ? "ON" : "OFF";
	}
	
	private function onClickBack():Void
	{
		gameSave.bind(Reg.objectSave);
		gameSave.data.enabledSkip = Reg.enabledSkip;
		gameSave.flush();
		
		trace(gameSave.data);
		
		FlxG.switchState(new MenuState());
	}
	
	private function onClickEnabledSkip():Void
	{
		Reg.enabledSkip = !Reg.enabledSkip;
	}
}