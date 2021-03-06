package;

import flixel.FlxSprite;

class GameObject extends FlxSprite
{
	static inline var SIZE:Int = 64;

	public var coordX:Int;
	public var coordY:Int;

	public function setCoordinate(x:Int, y:Int)
	{
		coordX = x;
		coordY = y;

		setPosition(x * SIZE, y * SIZE);
	}
}
