package;

import CommandManager.Command;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;

typedef Point =
{
	x:Int,
	y:Int
};

class Player extends GameObject
{
	var commandManager:CommandManager;
	var actionManager = new FlxActionManager();

	var up = new FlxActionDigital();
	var down = new FlxActionDigital();
	var left = new FlxActionDigital();
	var right = new FlxActionDigital();

	public var blocks:FlxTypedGroup<GameObject>;

	public function new(x:Int = 0, y:Int = 0, commander:CommandManager)
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

		loadGraphic(AssetPaths.sokoban_tilesheet__png, true, 64, 64);
		animation.add("left", [94, 95, 96, 94], 15, false);
		animation.add("right", [91, 92, 93, 91], 15, false);
		animation.add("up", [55, 56, 57, 55], 15, false);
		animation.add("down", [52, 53, 54, 52], 15, false);
		animation.add("idle", [52]);
		animation.play("idle");
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement()
	{
		var cmd:Command = null;

		if (up.triggered)
		{
			cmd = move({x: 0, y: -1}, "up");
		}
		else if (down.triggered)
		{
			cmd = move({x: 0, y: 1}, "down");
		}
		else if (left.triggered)
		{
			cmd = move({x: -1, y: 0}, "left");
		}
		else if (right.triggered)
		{
			cmd = move({x: 1, y: 0}, "right");
		}

		if (cmd != null)
			commandManager.addCommand(cmd);
	}

	function move(dir:Point, animationName:String):Command
	{
		var next = {x: coordX + dir.x, y: coordY + dir.y};

		for (block in blocks)
		{
			var collides = block.coordX == next.x && block.coordY == next.y;

			if (collides && !block.passable && !block.moveable)
			{
				return null;
			}
			else if (collides && block.moveable)
			{
				//
			}
		}

		return createMove(next, animationName);
	}

	function createMove(next:Point, animationName:String):Command
	{
		function execute()
		{
			setCoordinate(next.x, next.y);
			animation.play(animationName);
		}

		var prev = {x: coordX, y: coordY};
		function undo()
		{
			setCoordinate(prev.x, prev.y);
			animation.play(animationName);
		}

		return {
			execute: execute,
			undo: undo
		};
	}
}
