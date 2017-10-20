package;

import haxe.Utf8;

import flixel.util.FlxTimer;
import haxe.Json;

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
		if (idx == null)
		{
			if (isNotPrinting())
			{
				index++;
			}
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
				textBox.text = "";
				
				#if neko
				trace(Utf8.validate(data.say));
				#end
				
				whoBox.text = Reg.character.say(data.who);
				printing(data.say);
		}
		
		Reg.currentScriptIndex = index;
	}
	
	private function printing(Say:String = "", Delay:Float = 0.15):Void
	{
		var offset:Int = 0;
		var size:Int = Say.length;
		
		if (isNotPrinting())
		{
			timer = new FlxTimer().start(Delay, function (e:FlxTimer):Void
			{
				var char:String = Say.charAt(offset);
				
				textBox.text += char;
				offset++;
			}, size);
		}
		else
		{
			textBox.text = Say;
			timer.cancel();
		}
	}
	
	public function dialogSave():Void
	{
		gameSave.bind(Reg.objectSave);
		gameSave.data.currentScriptIndex = Reg.currentScriptIndex;
		gameSave.flush();
	}
	
	private function isNotPrinting():Bool
	{
		if (timer == null)
		{
			return true;
		}
		
		if (timer.active == false)
		{
			return true;
		}
		
		return false;
	}
}