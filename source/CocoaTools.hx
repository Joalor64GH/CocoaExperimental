package;

import flixel.system.FlxSound;
import haxe.Json;
import sys.io.File;

// lmao using CocoaTools in CocoaTools
using CocoaTools;
using StringTools;

class CocoaTools
{
	public static function resetMusic(?checkPlaying:Bool = true)
	{
		if (FlxG.sound.music != null)
			if (checkPlaying && FlxG.sound.music.playing)
				FlxG.sound.music.stop();

		FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}

	public static function destroyMusic(music:FlxSound)
	{
		music.stop();
		music.destroy();
	}

	public static function returnJudgements():Array<String>
	{
		var array:Array<String> = File.getContent(Paths.getPath('songs/judgementList.txt')).split(':');
		return array.copy().toUpperCase().replace(' ', '');
	}

	public static function beautifyEvents(event:Array<Array<Dynamic>>):Array<Array<Dynamic>>
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

	public static function convertEvents(rawJson:String):Array<Array<Dynamic>>
	{
		var willReturn:Array<Array<Dynamic>> = [];
		var got:Array<Array<Dynamic>> = Json.parse(rawJson).events;

		for (i in got)
		{
			if (i[0] == null)
				i[0] = -1;

			var values:Array<Dynamic> = i[1];

			for (e in values)
				willReturn.push([e[0], i[0], e[1], e[2]]);
		}

		return willReturn;
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
}