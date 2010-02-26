package  
{
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	import org.flixel.FlxEmitter;
	public class Gun extends FlxEmitter
	{
		//Ammo that the gun has in one clip.  Ammo is given by the AI in multiples of the clip.
		private var ammo:int;
		
		//The spread of the gun's bullets.  Determines accuracy.  
		//0 means the gun shoots in a 180 degree cone in front of the player, 1.0 means it is perfectly accurate.
		//Mapping: (1-spread)*90 = right, (1-spread)*(-90) = left
		private var spread:Number;
		
		//The damage each bullet does
		private var damage:int;
		
		//The number of bullets to fire each second
		private var fireRate:int;
		
		public function Gun() 
		{
			
		}
		
	}

}