package  
{
	import org.flixel.*;
	import org.flashdevelop.utils.FlashConnect;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Andrew Tremblay
	 * (unless otherwise noted)
	 */
	public class AIDirector extends FlxObject
	{
		
			private var timer:Number = 1;
			private var altTimer:Number = 1;
			
			private var waves:int = 0;
			
			private var zombieNum:Number = 200;
			private var numZombies:int = 1;
			
			private var playersLeft:Number = 4; 
			
			//temporary variables 
			private var curBored:Number = 0;
			private var curExcite:Number = 0;
			private var curStress:Number = 0;
			private var prevBored:Number = 0;
			private var prevExcite:Number = 0;
			private var prevStress:Number = 0;
			
			private var numChoiceA:int = 0;
			private var numChoiceB:int = 0;

			//enum hack for easier array referencing
			private const boredom:Number = 0; 
			private const excite:Number = 1; 
			private const stress:Number = 2;
			//...
			private var playerData:Array = new Array(0, 0, 0); //stores (boredom, excite, stress))
			private var timeSlice:Array = new Array(playerData, playerData, playerData, playerData); //stores each player data of a moment in an array of its own
			private var allTime:Array = new Array(timeSlice); //stores player data for every player (be careful with this)
			 
			private var arrayData:Array = new Array(0, 0, 0, 0);//stores (spout, victim, speed, health)) of the spawned zombie
			private var zombieData:Array = new Array(arrayData); // stores the zombie data of the previous zombies 
			
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
			playersLeft = GameState.players.countLiving();
			//initialize the arrays
			for each(var t:TestModeler in GameState.playerModels.members) {
					t.getID();
				} 
			
			//GameState.makeZombie(GameState.SPOUT_1, GameState.players.getRandom() as Player, 100, 100);
			//GameState.makeZombie(GameState.SPOUT_4, GameState.players.getRandom() as Player, 100, 100);
			super();
		}
		
		public function getNewVars():void {
				playersLeft = GameState.players.countLiving();
				//For every player, get new player variables from it's playerModel
				for each(var t:TestModeler in GameState.playerModels.members) {
						curBored = t.getBoredom();
						curExcite = t.getExcitement();
						curStress = t.getStress();
					}
			}	
			
		public function getAverageVars():void {
			playersLeft = GameState.players.countLiving();
			curBored = 0;
			curExcite = 0;
			curStress = 0;
			for each(var t:TestModeler in GameState.playerModels.members) {
				// make sure player is alive
				if (t.getHealth() > 0) {
					curBored += t.getBoredom();
					curExcite += t.getExcitement();
					curStress += t.getStress();
				}
			}
			curBored /= playersLeft;
			curExcite /= playersLeft;
			curStress /= playersLeft;
		}
			
		public function constantRandomHeuristic():void{
				timer -= FlxG.elapsed;
				if (timer <= 0) {
					spawnRandomZombie();
					timer = 3;
				}
			}
		
		
		public function placeHolderHeuristic():void {
			//compares new vars to old vars
			
			//determines how much each var needs to be changed
			
			//alters the spouts appropriately
			
		}
			
		public function spawnRandomZombie():void { //original author Kevin Nolan
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
			
			var zombieConst:Number = 200; //editable while still keeping the zombie balanced
			
			var zHealth:Number = Math.floor(Math.random() * zombieConst);
			var zSpeed:int = zombieConst- zHealth; // we don't want super fast tank zombies, at least not initially
			
			var whoNum:Number = Math.floor(Math.random() * 4);
			var victim:Player = GameState.getPlayerByID(whoNum);//Determine who the zombie will initially attack
			storeChoice(spoutNum, whoNum, zHealth, zSpeed); //keep track of the selection for later analysis
			
			GameState.makeZombie(spout, victim, zSpeed, zHealth);
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
			var victim:Player = GameState.getPlayerByID(whoNum);//Determine who the zombie will initially attack
			
			//these are still random
			var zHealth:Number = Math.floor(Math.random() * 200);
			var zSpeed:int = Math.floor(Math.random() * 200);
			
			storeChoice(where, whoNum, zHealth, zSpeed); //keep track of the selection for later analysis
			
			GameState.makeZombie(spout, victim, zSpeed, zHealth);
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
		
		public function storeTimeSlice(where:Number, whoNum:Number, zHealth:Number, zSpeed:Number):void {
			
		}
		
		/*
		 * Basic heuristic: spawns zombies with random targets based on the average boredom, 
		 * excitement, and stress of all the players.
		 */
		public function basicHeuristic():void {
			// if time for new wave
			timer -= FlxG.elapsed;
			if (timer <= 0) {
				timer = 3;
				
				getAverageVars();
				
				// pick a random spout
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
				
				// decide how to alter the zombie constant and number of zombies
				// Player is more bored than excited...make more zombies, tougher/faster
				if (curBored > curExcite) {
					zombieNum += (curBored - curExcite);
					numZombies += 1;
				}
				// Player is stressed but not having fun...make fewer zombies, slower/weaker
				else if (curStress > curExcite) {
					zombieNum -= (curStress - curExcite);
					numZombies -= 1;
				}
				// Otherwise, keep zombie constants the same
				
				// Generate zombies
				for (var i:int = 0; i < numZombies; i++) {
					var zombieHealth:Number = Math.floor(Math.random() * zombieNum);
					var zombieSpeed:int = zombieNum - zombieHealth;
					// store choice later?
					GameState.makeZombie(spout, GameState.players.getRandom() as Player, zombieSpeed, zombieHealth);
				}
			}
		}
		
		/*
		 * Delta heuristic: spawns zombies with random targets based on the change in average boredom, 
		 * excitement, and stress of all the players since the previous wave.
		 */
		public function deltaHeuristic():void {
			// if time for new wave
			timer -= FlxG.elapsed;
			if (timer <= 0) {
				timer = 3;
				
				// pick a random spout
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
				
				// update emotion values
				prevBored = curBored;
				prevExcite = curExcite;
				prevStress = curStress;
				getAverageVars();
				
				var deltaBored:Number = curBored - prevBored;
				var deltaExcite:Number = curExcite - prevExcite;
				var deltaStress:Number = curStress - prevStress;
				
				// decide how to alter the zombie constant and number of zombies
				// Player has gotten more stressed
				if (deltaStress > 0.5) {
					zombieNum -= (deltaStress * 2);
					numZombies -= 1;
				}
				// Player is not excited enough
				else if (deltaExcite < 3) {
					zombieNum += (deltaExcite * 2);
					numZombies += 1;
				}
				// Otherwise, keep zombie constants the same
				
				// Generate zombies
				for (var i:int = 0; i < numZombies; i++) {
					var zombieHealth:Number = Math.floor(Math.random() * zombieNum);
					var zombieSpeed:int = zombieNum - zombieHealth;
					// store choice later?
					GameState.makeZombie(spout, GameState.players.getRandom() as Player, zombieSpeed, zombieHealth);
				}
			}
		}
		
		/*
		 * Descending delta heuristic: like the delta heuristic, but is only allowed to make the same choice
		 * a certain number of times in a row, and the effect of that choice decreases each time.
		 */
		public function decreasingDeltaHeuristic():void {
			// if time for new wave
			timer -= FlxG.elapsed;
			if (timer <= 0) {
				timer = 3;
				
				// pick a random spout
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
				
				// update emotion values
				prevBored = curBored;
				prevExcite = curExcite;
				prevStress = curStress;
				getAverageVars();
				
				var deltaBored:Number = curBored - prevBored;
				var deltaExcite:Number = curExcite - prevExcite;
				var deltaStress:Number = curStress - prevStress;
				
				var maxTimes:int = 5;
				
				// decide how to alter the zombie constant and number of zombies
				// Player has gotten more stressed
				if (deltaStress > 0.5) {
					if (numChoiceA < maxTimes) {
						zombieNum -= (deltaStress * 2) * ((maxTimes - numChoiceA) / maxTimes);
						numZombies -= 1;
						numChoiceA++;
					}
					else {
						numChoiceA = 0;
					}
				}
				// Player is not excited enough
				else if (deltaExcite < 3) {
					if (numChoiceB < maxTimes) {
						zombieNum += (deltaExcite * 2) * ((maxTimes - numChoiceB) / maxTimes);
						numZombies += 1;
						numChoiceB++;
					}
					else {
						numChoiceB = 0;
					}
				}
				// Otherwise, keep zombie constants the same
				
				// Generate zombies
				for (var i:int = 0; i < numZombies; i++) {
					var zombieHealth:Number = Math.floor(Math.random() * zombieNum);
					var zombieSpeed:int = zombieNum - zombieHealth;
					// store choice later?
					GameState.makeZombie(spout, GameState.players.getRandom() as Player, zombieSpeed, zombieHealth);
				}
			}
		}
		
		public function getWaves():int {
			return waves;
		}
		
		override public function update():void {
			//getNewVars();
			//new heuristic goes here
			//constantRandomHeuristic();
			//placeHolderHeuristic();
			
			//If all players are dead, stop the game
			if (GameState.players.countLiving() == 0) {
				return;
			}
			
			waves++;
			
			//var text:String = "Players: " + GameState.players.countLiving() + " Boredom: " + curBored + " Excitement: " + curExcite + " Stress: " + curStress;
			//FlashConnect.trace(text);
			
			// run the basic heuristic
			//basicHeuristic();
			
			// run the delta heuristic
			//deltaHeuristic();
			
			// run the decreasing delta heuristic
			decreasingDeltaHeuristic();
			
			super.update();
			}
		
	}
}