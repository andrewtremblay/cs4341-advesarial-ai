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
		
		public function Bullet() 
		{
			loadGraphic(ImgBullet, true, true, 64, 64);
		}
		
	}

}