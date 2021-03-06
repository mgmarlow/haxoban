package;

import flixel.util.FlxColor;

class Wall extends GameObject
{
	public function new(x:Int = 0, y:Int = 0)
	{
		super(x * GameObject.SIZE, y * GameObject.SIZE);
		makeGraphic(GameObject.SIZE, GameObject.SIZE, FlxColor.RED);
	}
}
