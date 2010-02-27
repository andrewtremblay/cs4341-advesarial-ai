package  
{
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	 
	public class Gun
	{		
		//Ammo that the gun has in one clip.  Ammo is given by the AI in multiples of the clip.
		public var ammo:int;
		
		//The spread of the gun's bullets.  Determines accuracy.  
		//0 means the gun shoots in a 180 degree cone in front of the player, 1.0 means it is perfectly accurate.
		//Mapping: (1-spread)*90 = right, (1-spread)*(-90) = left
		public var spread:Number;
		
		//The damage each bullet does
		public var damage:int;
		
		//The number of bullets to fire each second
		public var fireRate:int;
		
		//The player to emit bullets from
		private var player:Player = null;
		
		//The timer to know when to fire
		private var timer:Number;
		
		//The amount to reset the timer to when it runs out.
		private var timeInterval:Number;
		
		/*
		 * Makes a gun with the given parameters.
		 * If random is true, it makes a random gun.
		 */
		public function Gun(_ammo:int,_spread:Number,_damage:int,_fireRate:int,random:Boolean) 
		{
			if(!random){
				ammo = _ammo;
				spread = _spread;
				damage = _damage;
				fireRate = _fireRate;
			} else {
				ammo = Math.floor(Math.random()*(1+100-20)) + 20;
				spread = Math.floor(Math.random()*64);
				damage = Math.floor(Math.random()*10) + 1;
				fireRate = Math.floor(Math.random()*10) + 1
			}
			
			timeInterval = 1 / fireRate;
			timer = timeInterval;
		}
		
		public function addPlayer(_player:Player):void {
			if (player == null) {
				player = _player;
			}
		}
		
		public function shoot(target:Zombie,time:Number):void {
			
			timer -= time;
			
			if (timer > 0) {
				return;
			}
			
			timer = timeInterval;
			
			//Current position of the player and target
			var spreadVariance:int = Math.floor(Math.random() * 2 * spread) - spread;
			var playerPos:Point = new Point(player.x, player.y);
			var targetPos:Point = new Point(target.x + spreadVariance, target.y);
			
			var bullet:Bullet = new Bullet(this.damage);
			bullet.x = player.x + 24;
			bullet.y = player.y + 64;
			
			var directionVector:Point = targetPos.subtract(playerPos);
			directionVector.normalize(GameState.BULLET_SPEED);
			bullet.velocity = new FlxPoint(directionVector.x, directionVector.y - 32);
			
			GameState.bullets.add(bullet);
			GameState.renderLayer.add(bullet);
		}
		
	}

}