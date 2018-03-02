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
	private var effectLayout:EffectLayout = Reg.effect;
	
	public function new(?MaxSize:Int=0, ?IsLoad:Bool=false):Void
	{
		super(MaxSize);
		
		textField = new FlxText(24, 24, 0, "PlayState");
		
		backgroundLayout.init();

		var bgimage:Background = new Background("bg", AssetPaths.background__png);
		backgroundLayout.append("bg", bgimage);

		var bgnight:Background = new Background("night", AssetPaths.night__png);
		backgroundLayout.append("night", bgnight);

		var bedroom:Background = new Background("bedroom", AssetPaths.bedroom__png);		
		backgroundLayout.append("bedroom", bedroom);
		
		//backgroundLayout.setBackground("bg");

		characterLayout.init();
		dialogBox.init();
		effectLayout.init();
		
		add(backgroundLayout);
		add(characterLayout);
		add(dialogBox);
		add(effectLayout);
		
		add(textField);
		
		var mc:Character = new Character("mc", "Джонатанн");
		characterLayout.append("mc", mc);
		
		var hana:Character = new Character("ha", "Хана");
		hana.addSprite("normal", AssetPaths.hana_school_confused__png);
		hana.addSprite("home", AssetPaths.hana_panty_smile__png);
		characterLayout.append("ha", hana);
		
		var gop1:Character = new Character("g1", "Gop 1");
		gop1.addSprite("normal", AssetPaths.g1__png);
		characterLayout.append("g1", gop1);
		
		var gop2:Character = new Character("g2", "Gop 2");
		gop2.addSprite("normal", AssetPaths.g2__png);
		characterLayout.append("g2", gop2);
		
		var gop3:Character = new Character("g3", "Gop 3");
		gop3.addSprite("normal", AssetPaths.g3__png);
		characterLayout.append("g3", gop3);
		
		if (IsLoad == true)
		{
			gameSave.bind(Reg.objectSave);
			dialogBox.next(gameSave.data.currentScriptIndex);
			
			if (gameSave.data.currentScene.background != null) {
				backgroundLayout.setBackground(gameSave.data.currentScene.background);
			}
			else
			{
				backgroundLayout.removeBackground();
			}
			
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
			backgroundLayout.setBackground("night");
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
		
		if (FlxG.mouse.justPressedMiddle)
		{
			dialogBox.hideOrShow;
		}
		
		if (FlxG.keys.justPressed.ESCAPE)
		{
			Reg.mode = Reg.GAME_MODE.NORMAL;
			
			goToTitle();
		}
		
		if (FlxG.keys.justPressed.CONTROL)
		{
			if (Reg.enabledSkip != true)
			{
				return;
			}
			
			trace("Pressed CTRL -> Skip Mode ON");
			skipTimer = new FlxTimer().start(0.1, function (timer:FlxTimer):Void
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
		effectLayout.clear();
		
		trace('PlayState destroy');
	}
	
	private function goToTitle():Void
	{
		Reg.currentScene = Reg.gameSave.getBackgroundData();
		Reg.currentChars = Reg.gameSave.getCharactersData();
		
		var gameSave:GameSave = Reg.gameSave;
		gameSave.bind(Reg.objectSave);
		gameSave.data.currentScene = Reg.currentScene;
		gameSave.data.currentChars = Reg.currentChars;
		gameSave.flush();
		
		FlxG.switchState(new MenuState());
	}
}