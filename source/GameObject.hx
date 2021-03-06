package;

import flixel.FlxSprite;

class GameObject extends FlxSprite
{
	static inline var SIZE:Int = 64;

	public var coordX:Int;
	public var coordY:Int;

	public var moveable = false;
	public var passable = false;

	public function new(coordX:Int = 0, coordY:Int = 0)
	{
		super(0, 0);
		setCoordinate(coordX, coordY);
	}

	public function setCoordinate(x:Int, y:Int)
	{
		coordX = x;
		coordY = y;

		setPosition(x * SIZE, y * SIZE);
	}
}
