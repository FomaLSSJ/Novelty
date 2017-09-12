package;

//import sys.io.File;
import haxe.Json;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class DialogBox extends FlxTypedGroup<Dynamic>
{
	private var imageBox:FlxSprite;
	private var whoBox:FlxText;
	private var textBox:FlxText;
	
	private var index = 0;
	private var script:Array<Map<String, Dynamic>> = [
		["key" => "message", "data" => {"who": "", "say": "..."}],
		["key" => "show", "data" => {}],
		["key" => "message", "data" => {"who": "Хана", "say": "Привет!"}],
		["key" => "message", "data" => {"who": "Хана", "say": "Нравятся мои трусики?"}],
		["key" => "message", "data" => {"who": "Хана", "say": "Можешь их снять :3"}],
		["key" => "message", "data" => {"who": "Хана", "say": "Но не сейчас :Р"}],
		["key" => "hide", "data" => {}],
		["key" => "message", "data" => {"who": "Рокет", "say": "Блэт!"}],
	];
	
	override public function new(MaxSize:Int=0):Void
	{
		super(MaxSize);
	}
	
	public function init():Void
	{
		imageBox = new FlxSprite();
		imageBox.makeGraphic(FlxG.width - 40, 96, FlxColor.GRAY);
		imageBox.setPosition(20, FlxG.height - (imageBox.height + 10));
		imageBox.alpha = 0.6;
	
		//var data:Dynamic = File.read(AssetPaths.script__json);
		//script = Json.parse(AssetPaths.script__json);
		
		//trace(data);
		
		whoBox = new FlxText(imageBox.x + 20, imageBox.y + 15, imageBox.width - 40, "...");
		whoBox.setFormat("Arial", 16);
		
		textBox = new FlxText(imageBox.x + 20, imageBox.y + 35, imageBox.width - 40, "...");
		textBox.setFormat("Arial", 14);
		
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
		
		if (index > script.length -1)
		{
			index = 0;
		}
	
		var key = script[index].get("key");
		var data = script[index].get("data");
		
		switch (key)
		{
			case "show":
				Reg.character.show();
				next();
			case "hide":
				Reg.character.hide();
				next();
			default:
				whoBox.text = data.who;
				textBox.text = data.say;
		}
	}
}