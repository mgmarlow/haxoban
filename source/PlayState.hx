package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var commander:CommandManager;

	var blocks:FlxGroup = new FlxGroup(100);

	override public function create()
	{
		commander = new CommandManager();

		var map = new FlxOgmo3Loader(AssetPaths.haxoban__ogmo, AssetPaths.room_001__json);
		var ground = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		add(ground);

		map.loadEntities(placeEntities, "entities");

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		blocks.update(elapsed);

		if (FlxG.keys.justPressed.Z)
			commander.undoCommand();
	}

	override public function draw()
	{
		super.draw();
		blocks.draw();
	}

	function placeEntities(entity:EntityData)
	{
		// Normalize coordinates based on tile size.
		var coordX = Std.int(entity.x / 64);
		var coordY = Std.int(entity.y / 64);

		var block = switch (entity.name)
		{
			case "player": new Player(coordX, coordY, commander);
			case "wall": new Wall(coordX, coordY);
			case "box": new Box(coordX, coordY);
			case "destination": new Destination(coordX, coordY);
			case _: null;
		}

		if (block != null)
			blocks.add(block);
	}
}
