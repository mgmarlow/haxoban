package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class VictoryState extends FlxState {
	public override function create() {
		var bg = new FlxBackdrop(AssetPaths.bg__png, 5, 5);
		add(bg);
		bg.velocity.set(-25, 50);

		var victory = new FlxText(0, 0, 0, "Success!", 32);
		add(victory);
		victory.screenCenter();
		victory.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		victory.y = victory.y - victory.height;

		var returnButton = new FlxButton(0, 0, "level select", clickReturn);
		add(returnButton);
		returnButton.screenCenter();

		super.create();
	}

	function clickReturn() {
		FlxG.switchState(new MenuState());
	}
}
