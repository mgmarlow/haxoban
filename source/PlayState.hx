package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var commander:CommandManager;

	var blocks:FlxTypedGroup<GameObject> = new FlxTypedGroup(100);
	var player:Player;

	override public function create()
	{
		commander = new CommandManager();

		var map = new FlxOgmo3Loader(AssetPaths.haxoban__ogmo, AssetPaths.room_001__json);
		var ground = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		add(ground);

		map.loadEntities(placeEntities, "entities");
		add(blocks);
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		player.blocks = blocks;

		if (FlxG.keys.justPressed.Z)
			commander.undoCommand();
	}

	function placeEntities(entity:EntityData)
	{
		// Normalize coordinates based on tile size.
		var coordX = Std.int(entity.x / 64);
		var coordY = Std.int(entity.y / 64);

		// Keep player separate so it doesn't get added to the
		// block FlxGroup.
		if (entity.name == "player")
		{
			player = new Player(coordX, coordY, commander);
		}

		var block = switch (entity.name)
		{
			case "wall": new Wall(coordX, coordY);
			case "box": new Box(coordX, coordY);
			case "destination": new Destination(coordX, coordY);
			case _: null;
		}

		if (block != null)
			blocks.add(block);
	}
}
