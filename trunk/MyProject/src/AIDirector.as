package  
{
	import org.flixel.*;
	import org.flashdevelop.utils.FlashConnect;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Andrew Tremblay
	 */
	public class AIDirector extends FlxObject
	{
		
			private var timer:Number = 1;
			private var varTimer:Number = 1;
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
			
			//GameState.makeZombie(GameState.SPOUT_1, GameState.players.getRandom() as Player, 100, 100);
			//GameState.makeZombie(GameState.SPOUT_4, GameState.players.getRandom() as Player, 100, 100);
			
			super();
		}


		override public function update():void {
			getNewVars();
			//new heuristic goes here
			constantRandomHeuristic();
			
				//If all players are dead, stop the game
				if (GameState.players.countLiving() == 0) {
					return;
				}
			super.update();
			}
		
		public function getNewVars():void {
				//For every player, get new player variables from it's playerModel
				
			}

		
		public function constantRandomHeuristic():void{
				timer -= FlxG.elapsed;
				if (timer <= 0) {
					spawnRandomZombie();
					timer = 4;
					
					//output
					FlashConnect.trace("Player 1: " + GameState.getPlayerByID(1).kills + " kills");
					FlashConnect.trace("Player 2: " + GameState.getPlayerByID(2).kills + " kills");
				}
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
				
		public function spawnRandomZombie():void {
			var spoutNum:Number = Math.ceil(Math.random() * 4);
			var spout:Point = GameState.SPOUT_1;
			
			if (spoutNum == 1) {
				spout = GameState.SPOUT_1;
			} else if (spoutNum == 2) {
				spout = GameState.SPOUT_2;
			} else if (spoutNum == 3) {
				spout = GameState.SPOUT_3;
			} else if (spoutNum == 4) {
				spout = GameState.SPOUT_4;
			}
			
			var zHealth:Number = Math.floor(Math.random() * 200);
			var zSpeed:int = 200 - zHealth; // Math.floor(Math.random() * 200);
			
			GameState.makeZombie(spout, GameState.players.getRandom() as Player, zSpeed, zHealth);
		}
		
		public function spawnZombie(where:Number, whoNum:Number):void {
			var spoutNum:Number = where; //the spout number where the zombie will spawn
			var spout:Point = GameState.SPOUT_1; //initial value, changed almost immediately
			
			if (spoutNum == 1) {
				spout = GameState.SPOUT_1;
			} else if (spoutNum == 2) {
				spout = GameState.SPOUT_2;
			} else if (spoutNum == 3) {
				spout = GameState.SPOUT_3;
			} else if (spoutNum == 4) {
				spout = GameState.SPOUT_4;
			}
			
			var zHealth:Number = Math.floor(Math.random() * 200);
			var zSpeed:int = Math.floor(Math.random() * 200);
			
			
			storeChoice(where, whoNum, zHealth, zSpeed); //keep track of the selection for later analysis
			
			GameState.makeZombie(spout, GameState.players.getRandom() as Player, zSpeed, zHealth);
		}
		
		public function spawnSpecificZombie(where:Number, whoNum:Number, zHealth:Number, zSpeed:Number):void {
			//Determine where the zombie will spawn
			var spoutNum:Number = where; //the spout number where the zombie will spawn
			var spout:Point = GameState.SPOUT_1; //initial value, changed almost immediately
			if (spoutNum == 1) {
				spout = GameState.SPOUT_1;
			} else if (spoutNum == 2) {
				spout = GameState.SPOUT_2;
			} else if (spoutNum == 3) {
				spout = GameState.SPOUT_3;
			} else if (spoutNum == 4) {
				spout = GameState.SPOUT_4;
			}
			
			var victim:Player = GameState.getPlayerByID(whoNum);//Determine who the zombie will initially attack
			storeChoice(where, whoNum, zHealth, zSpeed); //keep track of the selection for later analysis
			GameState.makeZombie(spout, victim, zSpeed, zHealth); // make the zombie with the variables 
		}
			
		
		public function storeChoice(where:Number, whoNum:Number, zHealth:Number, zSpeed:Number):void {
			
		}
		
	}
}