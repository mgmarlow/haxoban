package;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class Destination extends GameObject
{
	public var blocks:FlxTypedGroup<GameObject>;

	public function new(x:Int = 0, y:Int = 0)
	{
		super(x, y);
		passable = true;
		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 64, 64);
		animation.add("idle", [37]);
		animation.play("idle");
	}

	override function update(elapsed:Float)
	{
		checkVictory();
		super.update(elapsed);
	}

	function checkVictory()
	{
		for (block in blocks)
		{
			if (block.coordX == coordX && block.coordY == coordY)
			{
				FlxG.switchState(new VictoryState());
			}
		}
	}
}
