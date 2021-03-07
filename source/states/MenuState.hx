package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class MenuState extends FlxState {
	override public function create() {
		var bg = new FlxBackdrop(AssetPaths.bg__png, 5, 5);
		add(bg);
		bg.velocity.set(-50, 50);

		var title = new FlxText(0, 0, 0, "Haxoban", 32);
		add(title);
		title.screenCenter();
		title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		title.y = title.y - title.height;

		var playButton = new FlxButton(0, 0, "Play", clickPlay);
		add(playButton);
		playButton.screenCenter();

		// #if FLX_MOUSE
		// FlxG.mouse.visible = false;
		// #end

		super.create();
	}

	function clickPlay() {
		FlxG.switchState(new PlayState());
	}
}
