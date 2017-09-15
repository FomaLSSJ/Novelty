package;

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
	private var imageBox:FlxSprite;
	private var whoBox:FlxText;
	private var textBox:FlxText;
	
	private var index = 0;
	public var dialogs:Array<Dynamic>;
	
	override public function new(MaxSize:Int=0):Void
	{
		super(MaxSize);
	}
	
	public function init():Void
	{
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
		
		next(0);
	}
	
	public function next(idx:Int=null):Void
	{
		if (idx == null)
		{
			index++;
		}
		else
		{
			index = idx;
		}
		
		if (index > dialogs.length -1)
		{
			index = 0;
		}

		var key = dialogs[index].key;
		var data = dialogs[index].data;
		
		var characters:Map<String, Character> = Reg.character.getCharacters();
		
		switch (key)
		{
			case "show":
				Reg.character.show(data.who, data.pose, data.from, data.to);

				next();
			case "hide":
				Reg.character.hide(data.who, data.to);

				next();
			default:
				whoBox.text = Reg.character.say(data.who);
				textBox.text = data.say;
		}
	}
}