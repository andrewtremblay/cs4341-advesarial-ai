package  
{
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		//An array to hold the players in
		private var players:Array;
		
		//An array to hold the zombies in
		public var zombies:Array;
		
		override public function GameState(): void
		{
			add(new FlxText(0, 0, 100, "Hello, World!"));
			super();
			
			players = new Array();
			zombies = new Array();
			
			players.push(new Player(320,240));
		}
		
	}

}