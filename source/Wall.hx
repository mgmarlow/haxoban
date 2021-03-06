package;

class Wall extends GameObject
{
	public function new(x:Int = 0, y:Int = 0)
	{
		super(x * GameObject.SIZE, y * GameObject.SIZE);
	}
}
