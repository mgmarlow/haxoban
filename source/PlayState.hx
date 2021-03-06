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
	var dest:Destination;

	override public function create()
	{
		commander = new CommandManager();

		var map = new FlxOgmo3Loader(AssetPaths.haxoban__ogmo, AssetPaths.room_001__json);
		var ground = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		add(ground);

		map.loadEntities(placeEntities, "entities");
		add(blocks);
		add(dest);
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		player.blocks = blocks;
		dest.blocks = blocks;
		super.update(elapsed);

		if (FlxG.keys.justPressed.Z)
			commander.undoCommand();
	}

	function placeEntities(entity:EntityData)
	{
		// Normalize coordinates based on tile size.
		var coordX = Std.int(entity.x / 64);
		var coordY = Std.int(entity.y / 64);

		if (entity.name == "player")
		{
			player = new Player(coordX, coordY, commander);
		}
		else if (entity.name == "destination")
		{
			dest = new Destination(coordX, coordY);
		}

		var block = switch (entity.name)
		{
			case "wall": new Wall(coordX, coordY);
			case "box": new Box(coordX, coordY);
			case _: null;
		}

		if (block != null)
			blocks.add(block);
	}
}
