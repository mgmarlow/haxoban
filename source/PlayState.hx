package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	var player:Player;
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

		if (entity.name == "player")
		{
			var player = new Player(coordX, coordY, commander);
			add(player);
		}
		else if (entity.name == "wall")
		{
			var wall = new Wall(coordX, coordY);
			blocks.add(wall);
		}
		else if (entity.name == "box")
		{
			var box = new Box(coordX, coordY);
			blocks.add(box);
		}
		else if (entity.name == "destination")
		{
			var dest = new Destination(coordX, coordY);
			blocks.add(dest);
		}
	}
}
