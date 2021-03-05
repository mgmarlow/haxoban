package;

class CommandManager
{
	private var commands:Array<() -> Void> = [];

	public function new() {}

	public function addCommand(execute:() -> Void, undo:() -> Void)
	{
		execute();
		commands.push(undo);
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
