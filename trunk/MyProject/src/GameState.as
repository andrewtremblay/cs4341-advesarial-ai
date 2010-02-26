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
		
		//The layer to render everything in
		private var renderLayer:FlxGroup;
		
		override public function GameState(): void
		{
			super();
			
			renderLayer = new FlxGroup();
			
			players = new Array();
			zombies = new Array();
			
			players.push(new Player(20, 20));
			
			for (var i:int = 0; i < players.length; i++) {
				renderLayer.add(players[i]);
			}
			
			this.add(renderLayer);
		}
		
	}

}