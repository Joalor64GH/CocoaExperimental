package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var gfVersion:String;
	var stage:String;
	var arrowSkin:String;
	var splashSkin:String;
	var validScore:Bool;
	var events:Array<Array<Dynamic>>;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var arrowSkin:String;
	public var splashSkin:String;
	public var speed:Float = 1;
	public var stage:String;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var gfVersion:String = 'gf';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?difficulty:Int = 0):SwagSong
	{
		var rawJson = null;

		var formattedFolder:String = Paths.formatToSongPath(jsonInput);
		var formattedSong:String = Paths.formatToSongPath(CoolUtil.difficultyStuff[difficulty]);

		var moddyFile:String = Paths.modsJson(formattedFolder + '/' + formattedSong);

		if (FileSystem.exists(moddyFile))
		{
			rawJson = File.getContent(moddyFile).trim();
		}

		if (rawJson == null)
			rawJson = File.getContent(Paths.json(formattedFolder + '/' + formattedSong)).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		var songJson:SwagSong = parseJSONshit(rawJson);

		var eventFile:String = Paths.modsJson('$formattedFolder/events.json');

		if (!FileSystem.exists(eventFile))
			eventFile = Paths.json('$formattedFolder/events.json');

		if (FileSystem.exists(eventFile))
			songJson.events = parseEVENTshit(eventFile);
		else
		{
			eventFile = Paths.modsJson('$formattedFolder/events-psych.json');
			
			if (!FileSystem.exists(eventFile))
				eventFile = Paths.json('$formattedFolder/events-psych.json');

			if (FileSystem.exists(eventFile))
				songJson.events = CocoaTools.convertEvents(File.getContent(eventFile));
			else
				songJson.events = [];
		}

		//trace(songJson.events);
		
		return songJson;
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}

	public static function parseEVENTshit(rawJson:String):Array<Array<Dynamic>>
	{
		return Json.parse(File.getContent(rawJson).trim()).events;
	}
}
