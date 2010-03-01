﻿package  
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
		//The speed bullets travel at
		public static const BULLET_SPEED:Number = 400;
		//The spouts that zombies come out of.  
		//Currently they spawn a little bit above the bottom of the screen.
		public static const SPOUT_1:Point = new Point(100,600);
		public static const SPOUT_2:Point = new Point(200,600);
		public static const SPOUT_3:Point = new Point(300,600);
		public static const SPOUT_4:Point = new Point(400,600);
		//The XY coordinates of the bottom right of the screen.
		//Bullet uses this to get rid of bullets when they leave the screen.
		public static const WINDOW_X:int = 640;
		public static const WINDOW_Y:int = -480;
		
		//An array to hold the players in
		public static var players:FlxGroup;
		
		//An array to hold the zombies in
		public static var zombies:FlxGroup;
		
		//An array to hold the bullets in
		public static var bullets:FlxGroup;
		
		//The layer to render everything in
		public static var renderLayer:FlxGroup;
		
		override public function GameState(): void
		{
			super();
			
			//I see a black background I want to paint it blue...
			bgColor = 0xff0000A0;
			
			//Initialize stuff
			renderLayer = new FlxGroup();
			
			players = new FlxGroup();
			zombies = new FlxGroup();
			bullets = new FlxGroup();
			
			//Add the players
			players.add(new Player(200, 20, new Gun(10,48,10,2,false)));
			players.add(new Player(300, 20, new Gun(15,48,5,5,false)));
			players.add(new Player(400, 20, new Gun(5,0,20,1,false)));
			players.add(new Player(100, 20, new Gun(30,64,3,10,false)));
			
			//zombies.push(new Zombie(300, 400, players[0], 100, 100));
			
			makeZombie(SPOUT_1, players.getRandom() as Player, 100, 100);
			
			for (var i:int = 0; i < players.members.length; i++) {
				renderLayer.add(players.members[i]);
			}
			
			/*
			for (var j:int = 0; j < zombies.length; j++) {
				renderLayer.add(zombies[j]);
			}
			*/
			
			this.add(renderLayer);
		}
		
		override public function update():void
        {
            super.update();
			
			//Check collisions between bullets and zombies.
			this.gotShot();
			
        }
		
		public static function makeZombie(_spout:Point,_player:Player, _speed:int, _health:Number):void
		{
			var xVar:int = Math.floor(Math.random() * 100);
			var yVar:int = Math.floor(Math.random() * 100);
			
			var newZombie:Zombie = new Zombie(_spout.x + xVar, _spout.y + yVar, _player, _speed, _health);
			zombies.add(newZombie);
			renderLayer.add(newZombie);
		}
		
		private function zombieShot(colBullet:Bullet, colZombie:Zombie):void
        {
			trace(colBullet.damage);
			colZombie.hurt(colBullet.damage);
            colBullet.kill();
			trace("Zombie was hurt");
        }
		
		private function gotShot():void
		{
			for each(var b:Bullet in bullets.members) {
				for each(var z:Zombie in zombies.members) {
					if(FlxU.collide(b,z))
					{	
						zombieShot(b, z);
						trace("Zombie was shot");
					} else {
					}
				}
			}
		}
		
	}

}