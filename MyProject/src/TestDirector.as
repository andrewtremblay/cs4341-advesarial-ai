package  
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * This class allows Fran and I to test the player side stuff before the real AI Director is done.
	 * @author knolan
	 */
	public class TestDirector extends FlxObject
	{		
		private var timer:Number = 3;
		
		override public function TestDirector() : void
		{
			super();
		}
		
		public function spawnZombie():void {
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
			var zSpeed:int = Math.floor(Math.random() * 200);
			
			GameState.makeZombie(spout, GameState.players.getRandom() as Player, zSpeed, zHealth);
		}
		
		override public function update():void {
			//If all players are dead, stop the game
			if (GameState.players.countLiving() == 0) {
				return;
			}
			timer -= FlxG.elapsed;
			
			if (timer <= 0) {
				spawnZombie();
				timer = 1;
			}
			
			super.update();
		}
		
	}

}