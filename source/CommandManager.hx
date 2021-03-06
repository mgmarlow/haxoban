package;

typedef Command =
{
	execute:() -> Void,
	undo:() -> Void
}

class CommandManager
{
	private var commands:Array<() -> Void> = [];

	public function new() {}

	public function addCommand(cmd:Command)
	{
		cmd.execute();
		commands.push(cmd.undo);
	}

	public function undoCommand()
	{
		if (commands.length <= 0)
		{
			return;
		}

		var undo = commands.pop();
		undo();
	}
}
