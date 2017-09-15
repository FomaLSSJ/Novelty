package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	private var skipTimer:FlxTimer;
	private var textField:FlxText;
	private var characters:Map<String, Character>;
	
	private var backgroundLayout:BackgroundLayout = Reg.background;
	private var characterLayout:CharacterLayout = Reg.character;
	private var dialogBox:DialogBox = Reg.dialogBox;
	
	override public function create():Void
	{
		textField = new FlxText(24, 24, 0, "Play State");
		
		backgroundLayout.setBackground(AssetPaths.background__png);

		characterLayout.init();
		
		dialogBox.init();
		
		add(backgroundLayout);
		add(characterLayout);
		add(dialogBox);
		
		add(textField);
		
		var hana:Character = new Character("ha", "Хана");
		hana.addSprite("normal", AssetPaths.hana_school_confused__png);
		hana.addSprite("home", AssetPaths.hana_panty_smile__png);
		
		characterLayout.append("ha", hana);
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.ENTER)
		{
			backgroundLayout.setBackground(AssetPaths.night__png);
		}
		
		if (FlxG.keys.justPressed.SPACE)
		{
			backgroundLayout.removeBackground();
		}
		
		if (FlxG.mouse.justPressed)
		{
			dialogBox.next();
		}
		
		if (FlxG.mouse.justPressedRight)
		{
			trace('click right');
		}
		
		if (FlxG.keys.justPressed.T)
		{
			Reg.enabledSkip = false;
		}
		
		if (FlxG.keys.justPressed.CONTROL)
		{
			if (Reg.enabledSkip != true)
			{
				return;
			}
			
			trace("Pressed CTRL -> Skip Mode ON");
			skipTimer = new FlxTimer().start(0.25, function (timer:FlxTimer):Void
			{
				dialogBox.next();
			}, 0);
		}
		
		if (FlxG.keys.justReleased.CONTROL)
		{
			trace("Released CTRL -> Skip Mode OFF");
			if (skipTimer != null)
			{
				skipTimer.destroy();
			}
		}
	}
}