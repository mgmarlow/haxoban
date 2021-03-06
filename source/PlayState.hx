package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var ground:FlxTilemap;
	var commander:CommandManager;

	var blocks:FlxGroup = new FlxGroup(100);

	override public function create()
	{
		commander = new CommandManager();

		map = new FlxOgmo3Loader(AssetPaths.haxoban__ogmo, AssetPaths.room_001__json);
		ground = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		ground.setTileProperties(89, FlxObject.NONE);
		ground.setTileProperties(19, FlxObject.ANY);
		add(ground);

		player = new Player(commander);
		map.loadEntities(placeEntities, "entities");

		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		blocks.update(elapsed);

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
			player.setCoordinate(coordX, coordY);
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
