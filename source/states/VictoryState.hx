package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class VictoryState extends FlxSubState {
	public override function create() {
		add(new objects.Overlay());

		var victory = new FlxText(0, 0, 0, "Success!", 32);
		add(victory);
		victory.screenCenter();
		victory.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		victory.y = victory.y - victory.height;

		var select = new FlxText(0, 0, 0, "Hit return to go back to the level select", 16);
		add(select);
		select.screenCenter();

		super.create();
	}

	public override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER) {
			FlxG.switchState(new MenuState());
		}
	}
}
