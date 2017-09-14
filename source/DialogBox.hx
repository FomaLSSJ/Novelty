package;

//import sys.io.File;
import flixel.math.FlxPoint;
import haxe.Json;

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
	private var script:Array<Map<String, Dynamic>> = [
		["key" => "message", "data" => {who: "", say: "..."}],
		["key" => "show", "data" => {who: "ha", pose: "home", from: "outleft", to: "left"}],
		["key" => "message", "data" => {who: "ha", say: "Привет!"}],
		["key" => "message", "data" => {who: "ha", say: "Нравятся мои трусики?"}],
		["key" => "message", "data" => {who: "ha", say: "Можешь их снять :3"}],
		["key" => "message", "data" => {who: "ha", say: "Но не сейчас :Р"}],
		["key" => "hide", "data" => {who: "ha", to: "outleft"}],
		["key" => "message", "data" => {who: "Рокет", say: "Блэт!"}],
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
		imageBox.alpha = 0.75;
	
		//var data:Dynamic = File.read(AssetPaths.script__json);
		//script = Json.parse(AssetPaths.script__json);
		
		//trace(data);
		
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
		
		if (index > script.length -1)
		{
			index = 0;
		}
	
		var key = script[index].get("key");
		var data = script[index].get("data");
		
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