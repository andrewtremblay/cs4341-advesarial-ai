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
		public var damage:int;
		
		public function Bullet(_damage:int) 
		{
			damage = _damage;
			loadGraphic(ImgBullet, true, true, 64, 64);
		}
		
		override public function update():void
        {
			super.update();
			
			if (y < -480 || x > 640) {
				exists = false;
			}
		}
	}

}