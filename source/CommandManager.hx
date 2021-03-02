package;

interface Command
{
	public function execute():Void;
	public function undo():Void;
}

class CommandManager
{
	private var commands:Array<Command> = [];

	public function new() {}

	public function addCommand(cmd:Command)
	{
		commands.push(cmd);
		cmd.execute();
	}

	public function undoCommand()
	{
		if (commands.length <= 0)
		{
			return;
		}

		var cmd = commands.pop();
		cmd.undo();
	}
}
