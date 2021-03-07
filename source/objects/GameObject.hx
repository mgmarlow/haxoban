package objects;

import CommandManager.Command;
import flixel.FlxSprite;

typedef Point = {
	x:Int,
	y:Int
};

class GameObject extends FlxSprite {
	static inline var SIZE:Int = 64;

	public var coordX:Int;
	public var coordY:Int;

	public var moveable = false;
	public var passable = false;

	public function new(coordX:Int = 0, coordY:Int = 0) {
		super(0, 0);
		setCoordinate(coordX, coordY);
	}

	public function setCoordinate(x:Int, y:Int) {
		coordX = x;
		coordY = y;

		setPosition(x * SIZE, y * SIZE);
	}

	public function move(dir:Point):Command {
		if (!moveable)
			return null;

		var next = { x: coordX + dir.x, y: coordY + dir.y };
		var animationName = getAnimationName(dir);
		function execute() {
			setCoordinate(next.x, next.y);
			animation.play(animationName);
		}

		var prev = { x: coordX, y: coordY };
		function undo() {
			setCoordinate(prev.x, prev.y);
			animation.play(animationName);
		}

		return {
			execute: execute,
			undo: undo
		};
	}

	function getAnimationName(dir:Point) {
		return switch (dir) {
			case { x: 1, y: 0 }: "right";
			case { x: -1, y: 0 }: "left";
			case { x: 0, y: 1 }: "down";
			case { x: 0, y: -1 }: "up";
			case _: null;
		};
	}
}
