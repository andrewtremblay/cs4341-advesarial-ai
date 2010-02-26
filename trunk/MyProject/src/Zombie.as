package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	public class Zombie extends FlxSprite
	{
		[Embed(source = '../lib/Zombie.png')] private var ImgZombie:Class;
		
		public function Zombie() 
		{
			loadGraphic(ImgZombie, true, true, 64, 64);
		}
		
	}

}