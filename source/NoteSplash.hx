package;

import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = new ColorSwap();

	public function new(x:Float, y:Float)
	{
		super(x, y);

		var skin:String = PlayState.SONG.splashSkin;

		if (skin == null)
			skin = (PlayState.isPixelStage ? 'AllnoteSplashesPIXEL' : 'AllnoteSplashes');

		frames = Paths.getSparrowAtlas(skin);

		animation.addByPrefix('splash 0 0', 'PurpC instance ', 24, false);
		animation.addByPrefix('splash 0 1', 'BlueC instance ', 24, false);
		animation.addByPrefix('splash 0 2', 'GreenC instance ', 24, false);
		animation.addByPrefix('splash 0 3', 'RedC instance ', 24, false);
		animation.addByPrefix('dodge splash', 'TrickyC instance ', 24, false);
		animation.addByPrefix('hurt splash', 'RedC instance ', 24, false);

		if (!PlayState.isPixelStage)
			antialiasing = !FunkySettings.noAntialiasing;
		else
			antialiasing = false;
	}

	public function spawnSplashNote(note:Note)
	{
		var noteData:Int = note.noteData;

		colorSwap.hue = FunkySettings.arrowHSV[noteData % 4][0] / 360;
		colorSwap.saturation = FunkySettings.arrowHSV[noteData % 4][1] / 100;
		colorSwap.brightness = FunkySettings.arrowHSV[noteData % 4][2] / 100;

		shader = colorSwap.shader;

		if (note.noteType == 'Hurt Note')
			animation.play('hurt splash', true);
		else if (note.noteType == 'Must Press Note')
			animation.play('dodge splash', true);
		else if (note.noteSplashTexture != null)
			animation.play(note.noteSplashTexture, true);
		else
			animation.play('splash 0 ${note.noteData}', true);

		animation.finishCallback = function(name)
		{
			kill();
		};

		if (PlayState.isPixelStage)
			animation.curAnim.frameRate = 10;
		else
			animation.curAnim.frameRate = 18;

		offset.set(width * 0.29, height * 0.29);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
