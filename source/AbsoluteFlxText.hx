package;

import flixel.FlxSprite;
import flixel.text.FlxText;

class AbsoluteFlxText extends FlxText
{
	public var tracker:FlxSprite;
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;

	public function new(FieldWidth:Float = 0, ?Text:String, Size:Int = 8, EmbeddedFont:Bool = true)
	{
		super(0, 0, FieldWidth, Text, Size, EmbeddedFont);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (tracker != null)
		{
			setPosition(tracker.x + offsetX, tracker.y + offsetY);
			angle = tracker.angle;
			alpha = tracker.alpha;
		}
	}
}
