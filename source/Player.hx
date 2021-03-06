package;

import flixel.FlxG;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;
import flixel.util.FlxColor;

class Player extends GameObject
{
	var commandManager:CommandManager;
	var actionManager = new FlxActionManager();

	var up = new FlxActionDigital();
	var down = new FlxActionDigital();
	var left = new FlxActionDigital();
	var right = new FlxActionDigital();

	public function new(x:Float = 0, y:Float = 0, commander:CommandManager)
	{
		super(x, y);

		setSize(64, 64);
		commandManager = commander;

		// Maybe throw this somewhere else?
		FlxG.inputs.add(actionManager);

		up.addKey(W, JUST_PRESSED);
		down.addKey(S, JUST_PRESSED);
		left.addKey(A, JUST_PRESSED);
		right.addKey(D, JUST_PRESSED);

		actionManager.addActions([up, down, left, right]);
		makeGraphic(GameObject.SIZE, GameObject.SIZE, FlxColor.BLUE);
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
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
		var prevX = coordX;
		var prevY = coordY;
		var nextX = coordX + dir.x;
		var nextY = coordY + dir.y;

		function execute()
		{
			setCoordinate(nextX, nextY);
		}

		function undo()
		{
			setCoordinate(prevX, prevY);
		}

		commandManager.addCommand(execute, undo);
	}
}
