package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	public class Player extends FlxSprite
    {
        [Embed(source='../lib/Player.png')] private var ImgPlayer:Class;
        
        private var _max_health:int = 100;
		
		private var ownedGun:Gun;
		
		private var target:Zombie = null;
        
        public function Player(X:Number,Y:Number,gun:Gun):void
        {
            super(X,Y);
			loadGraphic(ImgPlayer, false, false, 64, 64);
            maxVelocity.x = 0;
            maxVelocity.y = 0;
			
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

			//If the player runs out of health, he is removed.
            if(dead)
            {
                exists = false;
                return;
            }
			
			//Shoot the gun here
			//Gun also needs a target
			//var bullet:Bullet = new Bullet(ownedGun);
            //GameState.lyrSprites.add(bullet);
			if (target == null){
				target = GameState.getRandomZombie();
			}
			
			ownedGun.shoot(target,FlxG.elapsed);
			
            super.update();
        }     
    }

}