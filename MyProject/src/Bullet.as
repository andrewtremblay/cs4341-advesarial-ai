package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source='../lib/Bullet.png')] private var ImgBullet:Class;
		
		//The damage that this bullet does.
		public var damage:Number;
		
		public function Bullet(_damage:Number) 
		{
			damage = _damage;
			loadGraphic(ImgBullet, true, true, 16, 16);
		}
		
		override public function update():void
        {
			super.update();
			
			if (y < GameState.WINDOW_Y || x > GameState.WINDOW_X || x < 0) {
				exists = false;
			}
		}
	}

}