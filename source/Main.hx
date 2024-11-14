package;

import flixel.FlxGame;
import flixel.FlxState;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;

#if CRASHES_ALLOWED
import Discord.DiscordClient;
import haxe.CallStack;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import sys.FileSystem;
import sys.io.File;
#end

#if desktop
import ALSoftConfig;
#end

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	public static var FPS:FPS = new FPS(10, 3, 0xFFFFFF);
	public static var ColorFilter:ColorBlindness;

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		addChild(new FlxGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));

		addChild(FPS);
		if (FPS != null)
		{
			FPS.visible = FunkySettings.showFPS;
		}

		#if html5
		FlxG.autoPause = FlxG.mouse.visible = false;
		#end

		#if CRASHES_ALLOWED
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end
	}

	//sqirra-rng
	#if CRASHES_ALLOWED
	function onCrash(exception:UncaughtErrorEvent):Void
	{
		var error:String = "";
		var date:String = DateTools.format(Date.now(), "%Y-%m-%d %H.%M.%S");
		var callstack:Array<StackItem> = CallStack.exceptionStack(true);

		for (i in callstack)
			switch (i)
			{
				case FilePos(s, f, l, c):
					error += 'Called from $f : (line $l)\n';
				default:
					Sys.println(i);
			}

		error += '\nUncaught Exception: ${exception.error}\nReport this to Github Repository:\nhttps://github.com/TheWorldMachine/Cocoa';

		if (!FileSystem.exists('./logs/'))
			FileSystem.createDirectory('./logs/');

		trace(error, date);

		File.saveContent('./logs/CocoaLog_$date.log', '$error\n');
		Sys.print('$error was saved!');

		Application.current.window.alert(error, "Game crashed!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end
}
