package;

using unifill.Unifill;

import flixel.group.FlxGroup;
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
import flixel.ui.FlxButton;

class DialogBox extends FlxTypedGroup<Dynamic>
{
	private var gameSave:GameSave = Reg.gameSave;
	
	private var imageBox:FlxSprite;
	private var whoBox:FlxText;
	private var textBox:FlxText;
	private var timer:FlxTimer;
	
	private var hide:Bool = false;
	private var index:Int = 0;
	private var lastPrint:Float = 0;
	private var who:String = "...";
	private var say:String = "...";
	private var menuButtons: Array<FlxButton>;
	private var groupButtons:FlxGroup = new FlxGroup();
	
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
			groupButtons.revive();
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
		add(groupButtons);
		
		//TODO При запуске инитим скрипт с самого начала
		next(0);
	}
	
	public function next(idx:Int=null):Void
	{	
		if (Reg.mode == Reg.GAME_MODE.MENU && idx == null)
		{
			return;
		}
		
		if (!this.active)
		{
			hideOrShow();
			
			return;
		}
		
		if (idx == null)
		{
			(textBox.text.length < say.length) ? textBox.text = say : index++;
		}
		else
		{
			index = (dialogs[idx].key == "menu" && idx != 0) ? --idx : idx;
		}

		if (index > dialogs.length -1)
		{
			Reg.effect.reset();
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
			case "effect":
				Reg.effect.start(data.delay, function ():Void
				{
					next();
				});
			case "menu":
				trace(data.items);

				var items:Array<Dynamic> = data.items;
				
				showMenu(items);

				next();
			case "label":
				trace(data);
				
				next();
			case "triggers":
				useTriggers(data.triggers);
				
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
	
	private function goToLabel(Label:String):Void
	{
		Reg.mode = Reg.GAME_MODE.NORMAL;
		menuButtons = [];
		groupButtons.clear();
		groupButtons.visible = groupButtons.alive = false;
		
		if (Label == "pass")
		{
			next();
		}
		
		var count:Int = 0;
		for (item in dialogs)
		{
			if (item.key == "label" && item.data == Label)
			{
				trace(dialogs[ count ]);
				index = count;
				next();
			}
			
			count++;
		}
		
		next();
	}
	
	private function useTriggers(Triggers:Dynamic=null):Void
	{
		if (Triggers == null)
		{
			return;
		}
		
		for (key in Reflect.fields(Triggers))
		{
			Reg.triggers.set(key, Reflect.field(Triggers, key));
		}
	}
	
	private function showMenu(Items:Array<Dynamic>):Void
	{
		Reg.mode = Reg.GAME_MODE.MENU;
		
		menuButtons = [];
		groupButtons.clear();
		
		for (item in Items)
		{
			var button:FlxButton = new FlxButton(0, 0, item.name, function ():Void
			{
				useTriggers(item.triggers);
				goToLabel(item.label);
			});
			button.makeGraphic(FlxG.width, 18, FlxColor.GRAY);
			button.alpha = 0.75;
			menuButtons.push(button);
		}
		
		var centerY:Float = FlxG.height / 2;
		
		var count:Int = 0;
		
		for (button in menuButtons)
		{
			button.y = count * (button.height + 8) + centerY;
			groupButtons.add(button);
			count++;
		}
		
		groupButtons.visible = groupButtons.alive = true;
	}
	
	public function hideOrShow():Void
	{
		if (Reg.mode == Reg.GAME_MODE.EFFECT || Reg.mode == Reg.GAME_MODE.MENU)
		{
			return;
		}
		
		active = !active;
		visible = !visible;
	}
	
	public function dialogSave():Void
	{
		gameSave.bind(Reg.objectSave);
		gameSave.data.currentScriptIndex = Reg.currentScriptIndex;
		gameSave.flush();
	}
}