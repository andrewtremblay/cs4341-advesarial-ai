package  
{
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	import flash.geom.Point;
	import org.flixel.*;
	
	public class GameState extends FlxState
	{
		//Global variables.
		public static const BULLET_SPEED:Number = 400;
		public static const SPOUT_1:Point = new Point(100,600);
		public static const SPOUT_2:Point = new Point(200,600);
		public static const SPOUT_3:Point = new Point(300,600);
		public static const SPOUT_4:Point = new Point(400,600);
		
		//An array to hold the players in
		private var players:Array;
		
		//An array to hold the zombies in
		public static var zombies:Array;
		
		//The layer to render everything in
		public static var renderLayer:FlxGroup;
		
		override public function GameState(): void
		{
			super();
			
			bgColor = 0xff0000A0;
			
			renderLayer = new FlxGroup();
			
			players = new Array();
			zombies = new Array();
			
			players.push(new Player(200, 20, new Gun(10,.8,10,2,false)));
			players.push(new Player(300, 20, new Gun(15,.7,5,5,false)));
			players.push(new Player(400, 20, new Gun(5,1,20,1,false)));
			players.push(new Player(100, 20, new Gun(30,.5,3,10,false)));
			
			zombies.push(new Zombie(300, 400, players[0], 100, 100));
			
			for (var i:int = 0; i < players.length; i++) {
				renderLayer.add(players[i]);
			}
			
			for (var j:int = 0; j < zombies.length; j++) {
				renderLayer.add(zombies[j]);
			}
			
			this.add(renderLayer);
		}
		
		override public function update():void
        {
            super.update();
        }
		
		public static function getRandomZombie():Zombie
		{
			var number:Number = Math.floor(Math.random() * zombies.length);
			
			if (number == zombies.length) {
				number--;
			}
			
			return zombies[number];
		}
		
		public static function makeZombie(_spout:Point,_player:Player, _speed:int, _health:int):void
		{
			var xVar:int = Math.floor(Math.random() * 100);
			var yVar:int = Math.floor(Math.random() * 100);
			
			var newZombie:Zombie = new Zombie(_spout.x + xVar, _spout.y + yVar, _player, _speed, _health);
			zombies.push(newZombie);
			renderLayer.add(newZombie);
		}
		
	}

}