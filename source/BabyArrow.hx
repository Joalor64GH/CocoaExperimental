package;

import flixel.FlxSprite;

using StringTools;

class BabyArrow extends FlxSprite
{
	var colorSwap:ColorSwap;

	public var holdTimer:Float = 0;

	var noteData:Int = 0;

	public function new(x:Float, y:Float, leData:Int)
	{
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		noteData = leData;
		super(x, y);
	}

	override function update(elapsed:Float)
	{
		if (holdTimer > 0)
		{
			holdTimer -= elapsed;

			if (holdTimer <= 0)
			{
				playAnim('static');
				holdTimer = 0;
			}
		}

		if (animation.curAnim.name == 'confirm' && !PlayState.isPixelStage)
			centerOrigin();

		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false)
	{
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();

		if (animation.curAnim.name == 'static')
		{
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		}
		else
		{
			colorSwap.hue = FunkySettings.arrowHSV[noteData % 4][0] / 360;
			colorSwap.saturation = FunkySettings.arrowHSV[noteData % 4][1] / 100;
			colorSwap.brightness = FunkySettings.arrowHSV[noteData % 4][2] / 100;

			if (animation.curAnim.name == 'confirm' && !PlayState.isPixelStage)
			{
				centerOrigin();
			}
		}
	}
}
