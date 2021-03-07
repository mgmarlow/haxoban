package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import objects.Box;
import objects.Destination;
import objects.GameObject;
import objects.Player;
import objects.Wall;

class PlayState extends FlxState {
	var commander:CommandManager;

	var blocks:FlxTypedGroup<GameObject> = new FlxTypedGroup(100);
	var player:Player;
	var dest:Destination;
	var selectedLevel:String;

	public function new(level:String) {
		super();
		selectedLevel = level;
	}

	override public function create() {
		var bg = new FlxBackdrop(AssetPaths.bg_plain__png, 5, 5);
		add(bg);

		var map = new FlxOgmo3Loader(AssetPaths.haxoban__ogmo, selectedLevel);
		var ground = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		add(ground);

		commander = new CommandManager();
		map.loadEntities(placeEntities, "entities");
		add(dest);
		add(blocks);
		add(player);

		super.create();
	}

	override public function update(elapsed:Float) {
		player.blocks = blocks;
		dest.blocks = blocks;
		super.update(elapsed);

		checkVictory();

		if (FlxG.keys.justPressed.Z)
			commander.undoCommand();

		if (FlxG.keys.justPressed.R)
			FlxG.switchState(new PlayState(selectedLevel));
	}

	function checkVictory() {
		for (block in blocks) {
			if (block.coordX == dest.coordX && block.coordY == dest.coordY) {
				openSubState(new states.VictoryState());
			}
		}
	}

	function placeEntities(entity:EntityData) {
		// Normalize coordinates based on tile size.
		var coordX = Std.int(entity.x / 64);
		var coordY = Std.int(entity.y / 64);

		if (entity.name == "player") {
			player = new Player(coordX, coordY, commander);
		} else if (entity.name == "destination") {
			dest = new Destination(coordX, coordY);
		}

		var block = switch (entity.name) {
			case "wall": new Wall(coordX, coordY);
			case "box": new Box(coordX, coordY);
			case _: null;
		}

		if (block != null)
			blocks.add(block);
	}
}
