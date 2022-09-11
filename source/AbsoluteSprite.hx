package;

import flixel.FlxSprite;

using StringTools;

class AbsoluteSprite extends FlxSprite
{
	public var tracker:FlxSprite;
	public var xAdd:Float = 0;
	public var yAdd:Float = 0;
	public var angleAdd:Float = 0;
	public var alphaAdd:Float = 0;

	public var copyAngle:Bool = true;
	public var copyAlpha:Bool = true;
	public var copyVisible:Bool = false;

	public function new(?file:String, ?anim:String = null, ?loop:Bool = false, ?setScrollFactor:Bool = true)
	{
		super();
		if (file != null)
		{
			if (anim != null)
			{
				frames = Paths.getSparrowAtlas(file);
				animation.addByPrefix('idle', anim, 24, loop);
				animation.play('idle');
			}
			else
			{
				loadGraphic(Paths.image(file));
			}
		}

		antialiasing = !FunkySettings.noAntialiasing;
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (tracker != null)
		{
			setPosition(tracker.x + xAdd, tracker.y + yAdd);
			scrollFactor.set(tracker.scrollFactor.x, tracker.scrollFactor.y);

			if (copyAngle)
				angle = tracker.angle + angleAdd;

			if (copyAlpha)
				alpha = tracker.alpha + alphaAdd;

			if (copyVisible)
				visible = tracker.visible;
		}
	}
}
