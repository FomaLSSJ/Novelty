package;

using unifill.Unifill;

import unifill.CodePoint;

import lime.project.Haxelib;

import haxe.Json;
import haxe.Timer;

import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

class DialogBox extends FlxTypedGroup<Dynamic>
{
	private var gameSave:GameSave = Reg.gameSave;
	
	private var imageBox:FlxSprite;
	private var whoBox:FlxText;
	private var textBox:FlxText;
	private var timer:FlxTimer;
	
	private var index:Int = 0;
	private var lastPrint:Float = 0;
	private var who:String = "...";
	private var say:String = "...";
	
	public var dialogs:Array<Dynamic>;
	
	override public function new(MaxSize:Int=0):Void
	{
		super(MaxSize);
	}
	
	override public function destroy():Void
	{
		trace("DialogBox destroy");
		index = 0;
		timer = null;
		kill();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		var size:Int = say.uLength();
		var cText:String = textBox.text;
		var cLength:Int = cText.uLength();
		
		if (whoBox.text != who)
		{
			whoBox.text = who;
		}

		if (Timer.stamp() - lastPrint > Reg.textSpeed)
		{
			lastPrint = Timer.stamp();
			
			if (cLength < size)
			{
				textBox.text += say.uCharAt(cLength);
			}
		}
	}
	
	public function init():Void
	{
		if (exists == false)
		{
			revive();
		}
		
		imageBox = new FlxSprite();
		imageBox.makeGraphic(FlxG.width - 40, 96, FlxColor.GRAY);
		imageBox.setPosition(20, FlxG.height - (imageBox.height + 10));
		imageBox.alpha = 0.75;
	
		dialogs = Script.json("assets/data/script.json");
		
		whoBox = new FlxText(imageBox.x + 20, imageBox.y + 15, imageBox.width - 40, "...");
		whoBox.setFormat(AssetPaths.helios_cond__ttf, 16, FlxColor.WHITE);
		
		textBox = new FlxText(imageBox.x + 20, imageBox.y + 35, imageBox.width - 40, "...");
		textBox.setFormat(AssetPaths.roboto_condensed__ttf, 14, FlxColor.WHITE);
		
		add(imageBox);
		add(whoBox);
		add(textBox);
		
		//TODO При запуске инитим скрипт с самого начала
		next(0);
	}
	
	public function next(idx:Int=null):Void
	{
		if (!this.active)
		{
			this.active = true;
			this.visible = true;

			return;
		}
		
		if (idx == null)
		{
			(textBox.text.length < say.length) ? textBox.text = say : index++;
		}
		else
		{
			index = idx;
		}

		if (index > dialogs.length -1)
		{
			index = 0;
		}
		
		var characters:Map<String, Character> = Reg.character.getCharacters();
		
		var key = dialogs[index].key;
		var data = dialogs[index].data;
		
		switch (key)
		{
			case "show":
				Reg.character.show(data.who, data.pose, data.from, data.to);

				next();
			case "hide":
				Reg.character.hide(data.who, data.to);

				next();
			case "bgshow":
				Reg.background.setBackground(data.name);
				
				next();
			default:
				trace(Reg.currentScriptIndex, index);
				
				if (Reg.currentScriptIndex != index)
				{
					textBox.text = "";
				}
				
				who = Reg.character.say(data.who);
				say = data.say;
		}
		
		Reg.currentScriptIndex = index;
	}
	
	public function dialogSave():Void
	{
		gameSave.bind(Reg.objectSave);
		gameSave.data.currentScriptIndex = Reg.currentScriptIndex;
		gameSave.flush();
	}
}