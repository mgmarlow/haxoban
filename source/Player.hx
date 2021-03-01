package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	static inline var SIZE:Int = 64;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(SIZE, SIZE, FlxColor.BLUE);
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement()
	{
		var dir = {x: 0, y: 0};

		if (FlxG.keys.anyJustReleased([UP, W]))
		{
			dir.y = -1;
		}
		else if (FlxG.keys.anyJustReleased([DOWN, S]))
		{
			dir.y = 1;
		}
		else if (FlxG.keys.anyJustReleased([LEFT, A]))
		{
			dir.x = -1;
		}
		else if (FlxG.keys.anyJustReleased([RIGHT, D]))
		{
			dir.x = 1;
		}

		var nextX = x + (dir.x * SIZE);
		var nextY = y + (dir.y * SIZE);

		if (outsideBounds(nextX, nextY))
		{
			return;
		}

		if (dir.x != 0 || dir.y != 0)
		{
			x = nextX;
			y = nextY;
		}
	}

	function outsideBounds(nextX:Float, nextY:Float)
	{
		return nextX < 0 || nextX > FlxG.width - SIZE || nextY < 0 || nextY > FlxG.height - SIZE;
	}
}
