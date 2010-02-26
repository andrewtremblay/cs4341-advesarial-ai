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
        
        public function Player(X:Number,Y:Number):void
        {
            super(X,Y);
			loadGraphic(ImgPlayer, false, true, 64, 64);
            maxVelocity.x = 0;
            maxVelocity.y = 0;
            //Set the player health
            health = 100;
            //bounding box tweaks
            width = 64;
            height = 64;
        }
    
        override public function update():void
        {

			//If the player runs out of health, he is removed.
            if(dead)
            {
                if(finished) exists = false;
                else
                    super.update();
                return;
            }
			
			//Shoot the gun here
			
            super.update();
        }     
    }

}