package;

class Destination extends GameObject
{
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
		// todo: win condition
		super.update(elapsed);
	}
}
