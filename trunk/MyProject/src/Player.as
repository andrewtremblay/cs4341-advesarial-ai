package  
{
	import org.flixel.*;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Kevin Nolan
	 * @author Francis Collins
	 */
	public class Player extends FlxSprite
    {
        [Embed(source='../lib/Player.png')] private var ImgPlayer:Class;
        
        private var _max_health:int = 100;
		
		private var ownedGun:Gun;
		
		private var target:Zombie = null;
		
		private var teamwork:Boolean = true;
		
		public var timesBeenHurt:Number = 0;
		
		public var kills:Number = 0;
		
		public var idNum:Number;
        
        public function Player(X:Number,Y:Number,gun:Gun,id:Number):void
        {
            super(X,Y);
			loadGraphic(ImgPlayer, false, false, 64, 64);
            maxVelocity.x = 0;
            maxVelocity.y = 0;
			
			idNum = id;
			
            //Set the player health
            health = 100;
			
            //bounding box tweaks
            width = 64;
            height = 64;
			
			ownedGun = gun;
			ownedGun.addPlayer(this);
        }
    
        override public function update():void
        {
			//If all players are dead, stop the game
			if (GameState.players.countLiving() == 0) {
				return;
			}

			//If the player runs out of health, he is removed.
            if(dead)
            {
                exists = false;
                return;
            }
			
			//Shoot the gun here
			//Gun also needs a target
			if (target == null || !target.exists) {
				if (GameState.zombies.countLiving() == 0)
				{
					target = null;
				}
				//if teamwork is on, all the players are going to target the zombie with
				//the largest amount of health and shoot him
				else if (teamwork)
				{
					for each(var z:Zombie in GameState.zombies.members)
					{
						if ((target == null || target.dead) && z.exists)
							target = z;
						else if (((z.health + z.velocity.x + z.velocity.y) > (target.health + target.velocity.x + target.velocity.y)) && z.exists)
							target = z;
					}
				}
				else target = GameState.zombies.getRandom() as Zombie;
			}
			else if (target != null)
				ownedGun.shoot(target,FlxG.elapsed);
			super.update();
        }
		
		public function getGun():Gun
		{
			return this.ownedGun;
		}
		
		override public function hurt(Damage:Number):void {
			super.hurt(Damage);
			
			timesBeenHurt++;
		}
		
		public function incrementKills():void {
			kills++;
		}
    }

}