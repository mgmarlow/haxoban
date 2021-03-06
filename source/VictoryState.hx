package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class VictoryState extends FlxState
{
	public override function create()
	{
		var victory = new FlxText(0, 0, 0, "Victory!", 22);
		add(victory);
		victory.screenCenter();
		victory.y = victory.y - victory.height;

		var returnButton = new FlxButton(0, 0, "level select", clickReturn);
		add(returnButton);
		returnButton.screenCenter();

		super.create();
	}

	function clickReturn()
	{
		FlxG.switchState(new MenuState());
	}
}
