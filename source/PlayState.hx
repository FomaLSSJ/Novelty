package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	private var gameSave:GameSave = Reg.gameSave;
	
	private var skipTimer:FlxTimer;
	private var textField:FlxText;
	private var characters:Map<String, Character>;
	
	private var backgroundLayout:BackgroundLayout = Reg.background;
	private var characterLayout:CharacterLayout = Reg.character;
	private var dialogBox:DialogBox = Reg.dialogBox;
	
	public function new(?MaxSize:Int=0, ?IsLoad:Bool=false):Void
	{
		super(MaxSize);
		
		textField = new FlxText(24, 24, 0, "PlayState");
		
		backgroundLayout.init();
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
		
		if (IsLoad == true)
		{
			gameSave.bind(Reg.objectSave);
			dialogBox.next(gameSave.data.currentScriptIndex);
			
			var chars:Array<Dynamic> = gameSave.data.currentChars;
			for (char in chars)
			{
				characterLayout.show(char.id, char.pose, char.coord);
			}
			
			gameSave.close();
		}
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
			goToTitle();
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
	
	override public function destroy():Void
	{
		super.destroy();
		
		dialogBox.dialogSave();
		
		backgroundLayout.clear();
		characterLayout.clear();
		dialogBox.clear();
		
		trace('PlayState destroy');
	}
	
	private function goToTitle():Void
	{
		Reg.currentChars = Reg.gameSave.getCharactersData();
		
		var gameSave:GameSave = Reg.gameSave;
		gameSave.bind(Reg.objectSave);
		gameSave.data.currentChars = Reg.currentChars;
		gameSave.flush();
		
		FlxG.switchState(new MenuState());
	}
}