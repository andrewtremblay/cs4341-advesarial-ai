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
		
		//The player that owns this bullet
		private var player:Number;
		
		public function Bullet(_damage:Number, _player:Number) 
		{
			damage = _damage;
			player = _player;
			loadGraphic(ImgBullet, true, true, 16, 16);
		}
		
		override public function update():void
        {
			//If all players are dead, stop the game
			if (GameState.players.countLiving() == 0) {
				return;
			}
			super.update();
			
			if (y < GameState.WINDOW_Y || x > GameState.WINDOW_X || x < 0) {
				exists = false;
			}
		}
		
		override public function kill():void {
			GameState.getPlayerByID(player).incrementKills();
			super.kill();
		}
	}

}