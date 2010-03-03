package  
{
	import flash.geom.Point;
	import mx.events.InterDragManagerEvent;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	public class Zombie extends FlxSprite
	{
		[Embed(source = '../lib/Zombie.png')] private var ImgZombie:Class;
		
		//A link to the player to chase after
		private var _player:Player;
		
		//How fast the zombie moves
		private var _moveSpeed:int;
		
		/*
		 * Takes in an x and y for position, and a player to chase after. 
		 */
		public function Zombie(X:Number,Y:Number,linkedPlayer:Player,speed:int, _health:int) 
		{
			super(X, Y);
			loadGraphic(ImgZombie, false, false, 64, 64);
			
			//Set the zombie health
            health = _health;
            //bounding box tweaks
            width = 64;
            height = 64;
			dead = false
			_player = linkedPlayer;
			_moveSpeed = speed;
		}
    
        override public function update():void
        {
			//If all players are dead, stop the game
			if (GameState.players.countLiving() == 0) {
				return;
			}
			//Current position of the player and zombie
			var playerPos:Point = new Point(_player.x, _player.y);
			var zombiePos:Point = new Point(this.x, this.y);
			
			//If the zombie runs out of health, he is removed.
            if(dead)
            {
                exists = false;
				GameState.zombies.remove(this);
                return;
            }
			
			//If the targeted player is dead, pick a different one
			if (_player.dead) {
				while(targetAlive()){}
			}
			
			
			var directionVector:Point = playerPos.subtract(zombiePos);
			directionVector.normalize(_moveSpeed);
			velocity = new FlxPoint(directionVector.x, directionVector.y);
			
            super.update();
        }
		private function targetAlive():Boolean {
			if (_player.dead) {
				_player = GameState.players.getRandom() as Player;
			}
			
			return _player.dead;
		}
		

	}

}