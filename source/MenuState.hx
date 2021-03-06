package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	override public function create()
	{
		var title = new FlxText(0, 0, 0, "Haxoban", 22);
		add(title);
		title.screenCenter();
		title.y = title.y - title.height;

		var playButton = new FlxButton(0, 0, "Play", clickPlay);
		add(playButton);
		playButton.screenCenter();

		super.create();
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}
}
