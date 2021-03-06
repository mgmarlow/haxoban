package;

import CommandManager.Command;
import flixel.FlxG;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionManager;

class Player extends GameObject
{
	var commandManager:CommandManager;
	var actionManager = new FlxActionManager();

	var up = new FlxActionDigital();
	var down = new FlxActionDigital();
	var left = new FlxActionDigital();
	var right = new FlxActionDigital();

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
			cmd = move({x: 0, y: -1});
			animation.play("up");
		}
		else if (down.triggered)
		{
			cmd = move({x: 0, y: 1});
			animation.play("down");
		}
		else if (left.triggered)
		{
			cmd = move({x: -1, y: 0});
			animation.play("left");
		}
		else if (right.triggered)
		{
			cmd = move({x: 1, y: 0});
			animation.play("right");
		}

		if (cmd != null)
			commandManager.addCommand(cmd);
	}

	function move(dir:{x:Int, y:Int}):Command
	{
		var prev = {x: coordX, y: coordY};
		var next = {x: coordX + dir.x, y: coordY + dir.y};

		function execute()
		{
			setCoordinate(next.x, next.y);
		}

		function undo()
		{
			setCoordinate(prev.x, prev.y);
		}

		return {
			execute: execute,
			undo: undo
		};
	}
}
