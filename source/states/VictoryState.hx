package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class VictoryState extends FlxSubState {
	public function new(level:Int) {
		Helper.saveNextLevel(level + 1);
		super();
	}

	public override function create() {
		add(new objects.Overlay());

		var victory = new FlxText(0, 0, 0, "Success!", 32);
		add(victory);
		victory.screenCenter();
		victory.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		victory.y -= victory.height;

		var select = new FlxText(0, 0, 0, "enter to continue", 18);
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
