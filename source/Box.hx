package;

class Box extends GameObject
{
	public function new(x:Int = 0, y:Int = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 64, 64);
		animation.add("idle", [7]);
		animation.play("idle");
	}
}
