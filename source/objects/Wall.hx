package objects;

class Wall extends GameObject {
	public function new(x:Int = 0, y:Int = 0) {
		super(x, y);
		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 64, 64);
		animation.add("idle", [19]);
		animation.play("idle");
	}
}
