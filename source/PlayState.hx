package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var textField:FlxText;
	
	private var backgroundLayout:BackgroundLayout = Reg.background;
	private var characterLayout:CharacterLayout = Reg.character;
	private var dialogBox:DialogBox = Reg.dialogBox;
	
	override public function create():Void
	{
		textField = new FlxText(24, 24, 0, "Play State");
		
		backgroundLayout.setBackground(AssetPaths.background__png);
		
		dialogBox.init();
		
		add(backgroundLayout);
		add(characterLayout);
		add(dialogBox);
		
		add(textField);
		
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
	}
}