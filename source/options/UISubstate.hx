package options;

class UISubstate extends BaseOptionsSubstate
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Configuring UI Settings';

		var option:Option = new Option('Note Splashes', // option name
			[
				"Everytime you hit a \"Sick!\", a firework effect will be shown.",
				// desc when this option is enabled
				"Everytime you hit a \"Sick!\", a firework effect won't be shown."
			], // desc when this option is disabled
			'noteSplash' // variable name FunkySettings.hx
		);
		addOption(option);

		var option:Option = new Option('Show FPS Counter', [
			"A little FPS and memory counter will be shown on the top left.",
			"FPS and memory counter will stay hidden."
		], 'showFPS');
		option.onChange = setFPSVisibility;
		addOption(option);

		var option:Option = new Option('Score Text Tween', [
			'Score text will tween when you hit a note.',
			'Score text will stay static when you hit a note.'
		], 'scoreTween');
		addOption(option);

		var option:Option = new Option('Show Time Bar', [
			'The bar showing your preferred time style will be shown.',
			'The bar showing your preferred time style won\'t be shown.'
		], 'timeLeft');
		addOption(option);

		var option:Option = new Option('Time Bar Style:', // option name
			["Bar will show how much time left or elapsed\nbased on your decision."],
			// single description
			'timeStyle', // variable name in FunkySettings.hx
			'string', // string
			['Time Left', 'Time Elapsed'] // available options
		);
		addOption(option);

		var option:Option = new Option('Hide HUD', [
			"HUD will be hidden (doesn't include the time bar).",
			'HUD will be shown (doesn\'t include the time bar).'
		], 'hideHud');
		addOption(option);

		var option:Option = new Option('Sustain Notes Style:', [
			'Sustain notes will be put behind the strums.', // Stepmania
			'Sustain notes will be put in front of the strums.', // Classic (Funkin)
			'Sustain notes will be removed from the strums\njust like old versions of Friday Night Funkin\' did.' //Old
		], 'sustainStyle', 'string',
		['Stepmania', 'Funkin', 'Old'], true);
		addOption(option);

		var option:Option = new Option('Judgement Skin:', ['Sets judgements skin. (Check judgementList.txt in songs/)'], 'judgementSkin', 'string', 
		CocoaTools.returnJudgements());
		addOption(option);

		super();
	}

	function setFPSVisibility():Void
		Main.FPS.visible = FunkySettings.showFPS;
}
