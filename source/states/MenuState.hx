package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Arrow extends FlxSprite {
	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);
		loadGraphic(AssetPaths.arrow_right__png);
	}
}

class MenuState extends FlxState {
	var arrow:Arrow;
	var selectedLevel = 0;

	inline static var NUM_LEVELS = 2;

	override public function create() {
		var bg = new FlxBackdrop(AssetPaths.bg__png, 5, 5);
		add(bg);
		bg.velocity.set(-25, 50);

		var title = new FlxText(0, 0, 0, "Haxoban", 64);
		add(title);
		title.screenCenter();
		title.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLACK, 4);
		title.y -= title.height;

		arrow = new Arrow();
		add(arrow);
		arrow.x = (FlxG.width / 4) - arrow.width;

		for (i in 1...(NUM_LEVELS + 1)) {
			var level = new FlxText(FlxG.width / 4, 0, 0, 'Level $i', 16);
			add(level);
			level.y = FlxG.height / 2 + (i * 24) - (level.height / 2);
		}

		#if FLX_MOUSE
		FlxG.mouse.visible = false;
		#end

		super.create();
	}

	override function update(elasped:Float) {
		super.update(elasped);

		arrow.y = FlxG.height / 2 + ((selectedLevel + 1) * 24) - (arrow.height / 2);

		if (FlxG.keys.justPressed.ENTER) {
			selectLevel();
		}

		if (FlxG.keys.justPressed.UP) {
			selectedLevel--;
			selectedLevel = Std.int(Math.abs(selectedLevel % NUM_LEVELS));
		} else if (FlxG.keys.justPressed.DOWN) {
			selectedLevel++;
			selectedLevel = selectedLevel % NUM_LEVELS;
		}
	}

	function selectLevel() {
		var level = selectedLevel + 1;
		var room = 'assets/data/room_00$level.json';

		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function() {
			FlxG.switchState(new PlayState(room));
		});
	}
}
