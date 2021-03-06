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

		var block:GameObject = null;

		if (entity.name == "player")
		{
			block = new Player(coordX, coordY, commander);
		}
		else if (entity.name == "wall")
		{
			block = new Wall(coordX, coordY);
		}
		else if (entity.name == "box")
		{
			block = new Box(coordX, coordY);
		}
		else if (entity.name == "destination")
		{
			block = new Destination(coordX, coordY);
		}

		if (block != null)
			blocks.add(block);
	}
}
