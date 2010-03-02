package  
{
	import flash.system.fscommand; 
	import org.flixel.*;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author Andrew Tremblay
	 */
	public class AIDirector extends FlxObject
	{
			/*
			 Expose this stuff to AIDirector: (scalars)
				health
				ammo
				perceptibility (commented out)
				kills
				timesBeenHurt
				zombiesICanSee 
			*/	
			public var Phealth:Number; 
			public var Pammo:Number; 
			public var Pkills:Number;
			public var Pperceptibility:Number;
			
			/*
			 Emotions:  (Number weighted -100 <-> 100)
				boredom
				excitement
				stress 
			 */		

		public function AIDirector() 
		{
			super();
			FlashConnect.trace("AI IS WATCHING");
		}


		override public function update():void {
			getNewVars();
			//new heuristic goes here
			placeHolderHeuristic();
			}
		
		public function getNewVars():void {
			//health = PlayerModeler.getPlayerHealth(); //("playername")
			//ammo = PlayerModeler.getPlayerAmmo(); //("playername")
			//kills = PlayerModeler.gerPlayerKills(); //("playername")	
		}
		
		
		public function placeHolderHeuristic():void {
			//compares new vars to old vars
			
			//determines how much each var needs to be changed
			
			//alters the spouts appropriately
			
		}
		
			public function getBoredom():int {
				var bored:Number = 0; 
				return bored;
				}
			public function getExcitement():int {
				var excited:Number = 0; 
				return excited;
				}
			public function getStress():int {
				var stressed:Number = 0;
				return stressed;
				}
			
		
	}
}