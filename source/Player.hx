package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	static inline var SIZE:Int = 64;

	public var coordX:Int;
	public var coordY:Int;

	var actionManager = new FlxActionManager();

	var up = new FlxActionDigital();
	var down = new FlxActionDigital();
	var left = new FlxActionDigital();
	var right = new FlxActionDigital();

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		setSize(64, 64);

		// Maybe throw this somewhere else?
		FlxG.inputs.add(actionManager);

		up.addKey(W, JUST_RELEASED);
		down.addKey(S, JUST_RELEASED);
		left.addKey(A, JUST_RELEASED);
		right.addKey(D, JUST_RELEASED);

		actionManager.addActions([up, down, left, right]);
		makeGraphic(SIZE, SIZE, FlxColor.BLUE);
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}

	public function setCoordinate(x:Int, y:Int)
	{
		coordX = x;
		coordY = y;

		setPosition(x * SIZE, y * SIZE);
	}

	function updateMovement()
	{
		if (up.triggered)
			doMove({x: 0, y: -1});
		else if (down.triggered)
			doMove({x: 0, y: 1});
		else if (left.triggered)
			doMove({x: -1, y: 0});
		else if (right.triggered)
			doMove({x: 1, y: 0});
	}

	function doMove(dir:{x:Int, y:Int})
	{
		var nextX = coordX + dir.x;
		var nextY = coordY + dir.y;

		// if (overlapsAt(nextX, nextY, FlxObject.ANY))
		// {
		// 	return;
		// }

		setCoordinate(nextX, nextY);
	}
}
