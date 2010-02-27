package  
{
	import org.flixel.*;
	[SWF(width = "640", height = "900", backgroundColor = "#0000A0")]
	[Frame(factoryClass="Preloader")]
	
	public class Game extends FlxGame
	{
		
		public function Game():void
		{
			super(640,900,GameState,1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
		}
		
	}

}