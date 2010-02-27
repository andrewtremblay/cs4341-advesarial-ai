package  
{
	import flash.geom.Point;
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
		public function Zombie(X:Number,Y:Number,linkedPlayer:Player,speed:int, health:int) 
		{
			super(X, Y);
			loadGraphic(ImgZombie, false, false, 64, 64);
			
			maxVelocity.x = 200;
            maxVelocity.y = 200;
            //Set the zombie health
            health = 100;
            //bounding box tweaks
            width = 64;
            height = 64;
			
			_player = linkedPlayer;
			_moveSpeed = speed;
		}
    
        override public function update():void
        {
			//Current position of the player and zombie
			var playerPos:Point = new Point(_player.x, _player.y);
			var zombiePos:Point = new Point(this.x, this.y);
			
			//If the zombie runs out of health, he is removed.
            if(dead)
            {
                if(finished) exists = false;
                else
                    super.update();
                return;
            }
			
			if(Point.distance(playerPos, zombiePos) > 50)
            {
				var directionVector:Point = playerPos.subtract(zombiePos);
				
				directionVector.normalize(_moveSpeed);
				
				velocity = new FlxPoint(directionVector.x, directionVector.y);
            } else {
				velocity.x = 0;
				velocity.y = 0;
			}
			
            super.update();
        }
		
	}

}