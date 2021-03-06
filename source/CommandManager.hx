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

	public function addCommands(cmds:Array<Command>)
	{
		function execute()
		{
			for (cmd in cmds)
			{
				cmd.execute();
			}
		}

		function undo()
		{
			for (cmd in cmds)
			{
				cmd.undo();
			}
		}

		var bulkCommand = {
			execute: execute,
			undo: undo
		};

		addCommand(bulkCommand);
	}

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
