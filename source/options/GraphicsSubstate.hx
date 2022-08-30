package options;

class GraphicsSubstate extends BaseOptionsSubstate
{
	var boyfriend:Boyfriend;

	public function new()
	{
		title = 'Graphics';
		rpcTitle = 'Graphics Settings Menu'; 

		var character:String = 'bf';

		if (FlxG.random.bool(10))
			character = 'bf-holding-gf';
		else if (FlxG.random.bool(10))
			character = 'controller-lmao';

		var option:Option = new Option('Low Quality', [
			'Game will disable some details to improve performance.',
			'Game won\'t disable anything.'
		], 'lowGraphics', 'bool');
		addOption(option);

		var option:Option = new Option('No Antialiasing', [
			'Your game\'s performance will be increased\nat the cost of looking sharper.',
			'Your game will look more pleasing\nat the cost of your performance based on your device.'
		], 'noAntialiasing', 'bool');
		addOption(option);

		var option:Option = new Option('Framerate', ["Pretty self explanatory, isn't it?"], 'framerate', 'int');
		option.minValue = 60;
		option.maxValue = 240;
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		addOption(option);

		var option:Option = new Option('Color Blindness Filter:', [
				'Sets a color filter to the entire game\nfor color blind people if not "NONE".'
			], 'colorFilter', 'dynamic', ColorBlindness.colorFilters
		);
		option.onChange = ColorBlindness.setFilter;
		addOption(option);

		super();

		boyfriend = new Boyfriend(840, 170, character);
		boyfriend.dance();
		boyfriend.animation.finishCallback = function(name:String) boyfriend.dance();
		boyfriend.visible = false;
		if (character != 'controller-lmao')
			boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.7));
		else 
		{
			boyfriend.y += 50;
			boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.9));
		}

		if (character == 'bf-holding-gf')
			boyfriend.x -= 75;
		add(boyfriend);
	}

	function onChangeFramerate()
	{
		if (FunkySettings.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = FunkySettings.framerate;
			FlxG.drawFramerate = FunkySettings.framerate;
		}
		else
		{
			FlxG.drawFramerate = FunkySettings.framerate;
			FlxG.updateFramerate = FunkySettings.framerate;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		boyfriend.visible = curOption.name == 'No Antialiasing';
		boyfriend.antialiasing = !FunkySettings.noAntialiasing;
	}
}
