package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
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
		
		characters = characterLayout.getCharacters();
		
		var hana:Character = new Character("Хана");
		hana.addSprite("normal", AssetPaths.hana_school_confused__png);
		hana.addSprite("home", AssetPaths.hana_panty_smile__png);
		
		characters.set("ha", hana);
		
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
			if (Reg.character.visible == true)
			{
				Reg.character.move();
			}
		}
	}
}