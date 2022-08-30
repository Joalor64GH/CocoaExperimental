package;

import sys.io.File;

// lmao using CocoaTools in CocoaTools
using CocoaTools;
using StringTools;

class CocoaTools
{
	public static var random(default, null):CocoaRandom = new CocoaRandom();

	public static function resetMusic(?checkPlaying:Bool = true)
	{
		if (FlxG.sound.music != null)
			if (checkPlaying && FlxG.sound.music.playing)
				FlxG.sound.music.stop();

		FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}

	public static function returnJudgements():Array<String>
	{
		var array:Array<String> = File.getContent(Paths.getPath('songs/judgementList.txt')).split(':');
		return array.copy().toUpperCase().replace(' ', '');
	}

	public static function beautifyEvents(event:Array<Array<Array<Dynamic>>>):Array<Array<Array<Dynamic>>>
	{
		for (i in event)
			if (i == null)
			{
				var index:Int = event.indexOf(i);
				event.remove(i);
				i = [];
				event.insert(index, i);
			}

		return event;
	}

	public static function toLowerCase(array:Array<String>):Array<String>
	{
		var copiedArray:Array<String> = array.copy();

		for (copy in copiedArray)
		{
			var index:Int = copiedArray.indexOf(copy);
			copiedArray.remove(copy);
			copy = copy.toLowerCase();
			copiedArray.insert(index, copy);
		}

		return copiedArray.copy();
	}

	public static function toUpperCase(array:Array<String>):Array<String>
	{
		var copiedArray:Array<String> = array.copy();

		for (copy in copiedArray)
		{
			var index:Int = copiedArray.indexOf(copy);
			copiedArray.remove(copy);
			copy = copy.toUpperCase();
			copiedArray.insert(index, copy);
		}

		return copiedArray.copy();
	}

	public static function replace(array:Array<String>, sub:String, by:String):Array<String>
	{
		var copy:Array<String> = array.copy();

		for (i in copy)
		{
			var index:Int = copy.indexOf(i);
			copy.remove(i);
			i.split(sub).join(by);
			copy.insert(index, i);
		}

		return array = copy;
	}

	public static function copy(bool:Null<Bool>):Bool
	{
		var string:String = Std.string(bool);
		var copy:Bool = true;

		if (string == 'null' || string == 'false')
			copy = false;

		return copy;
	}
}

class CocoaRandom
{
	public function new()
	{}

	public function bool(float:Float = 50)
	{
		float /= 100;

		var num:Float = 0;

		while (true)
		{
			var random:Float = Math.random();
			if (random >= 0)
			{
				num = random;
				break;
			}
		}

		return num <= float;
	}
}