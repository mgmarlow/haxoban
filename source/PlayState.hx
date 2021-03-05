package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var commander:CommandManager;

	override public function create()
	{
		commander = new CommandManager();

		map = new FlxOgmo3Loader(AssetPaths.haxoban__ogmo, AssetPaths.room_001__json);
		walls = map.loadTilemap(AssetPaths.sokoban_tilesheet__png, "walls");
		walls.setTileProperties(89, FlxObject.NONE);
		walls.setTileProperties(19, FlxObject.ANY);
		add(walls);

		player = new Player(commander);
		map.loadEntities(placeEntities, "entities");

		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
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
			player.setCoordinate(coordX, coordY);
		}
	}
}
