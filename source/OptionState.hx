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
	
	private var buttonSpeedInstant:FlxButton;
	private var buttonSpeedMedium:FlxButton;
	private var buttonSpeedSlow:FlxButton;
	private var textSpeedLabel:FlxText;
	
	override public function create():Void
	{
		gameSave.bind(Reg.objectSave);
		Reg.enabledSkip = (gameSave.data.enabledSkip == true) ? true : false;
		Reg.textSpeed = (gameSave.data.textSpeed != null) ? gameSave.data.textSpeed : 0;
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
		
		buttonSpeedInstant = new FlxButton(0, 0, "Instant", function ():Void
		{
			Reg.textSpeed = 0;
		});
		buttonSpeedInstant.setPosition(FlxG.width / 4 - buttonEnabledSkip.width / 2, FlxG.height / 1.8);
		add(buttonSpeedInstant);
		
		buttonSpeedMedium = new FlxButton(0, 0, "Medium", function ():Void
		{
			Reg.textSpeed = 0.15;
		});
		buttonSpeedMedium.setPosition(buttonSpeedInstant.x + buttonSpeedInstant.width + 8, FlxG.height / 1.8);
		add(buttonSpeedMedium);
		
		buttonSpeedSlow = new FlxButton(0, 0, "Slow", function ():Void
		{
			Reg.textSpeed = 0.3;
		});
		buttonSpeedSlow.setPosition(buttonSpeedMedium.x + buttonSpeedMedium.width + 8, FlxG.height / 1.8);
		add(buttonSpeedSlow);
		
		textSpeedLabel = new FlxText(0, 0, 0, "...");
		textSpeedLabel.setPosition(FlxG.width / 1.5 - textSpeedLabel.width / 2, FlxG.height / 1.8);
		
		add(textSpeedLabel);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		textEnabledSkip.text = (Reg.enabledSkip == true) ? "ON" : "OFF";
		textSpeedLabel.text = Std.string(Reg.textSpeed);
	}
	
	private function onClickBack():Void
	{
		gameSave.bind(Reg.objectSave);
		gameSave.data.enabledSkip = Reg.enabledSkip;
		gameSave.data.textSpeed = Reg.textSpeed;
		gameSave.flush();
		
		trace(gameSave.data);
		
		FlxG.switchState(new MenuState());
	}
	
	private function onClickEnabledSkip():Void
	{
		Reg.enabledSkip = !Reg.enabledSkip;
	}
}