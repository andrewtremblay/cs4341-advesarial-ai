package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Francis Collins
	 */
	public class TestModeler  extends FlxSprite implements PlayerModeler
	{
		protected var player:Player;			//player the test modeler cooresponds to
		protected var boredom:Number;			//current boredom amount
		protected var excitement:Number;		//current excitement amount
		protected var stress:Number;			//current stress amount
		protected var healthness:Number;		//current health
		protected var ammo:Number;				//current ammo
		protected var kills:Number;				//number of kills
		protected var timesHurt:Number;			//number of times player's been hurt
		protected var visibleZombies:Number;	//number of zombies visibile
		
		//constructs the test modeler
		//all values set according to player given as argument
		public function TestModeler(_player:Player)
		{
			this.player = _player;
			this.healthness = player.health;
			this.ammo = player.getGun().ammo;
			this.kills = player.kills;
			this.timesHurt = (100 - player.health) / player.getGun().damage;
			this.visibleZombies = GameState.zombies.countLiving();
		}
		
		public function getID():Number 
		{
			return this.player.idNum;
		}
		
		//boredom, excitement, and stress all based off values ranging between 0 and 100
		//ex: timesHurt 0 <-> 100
		//cannot calculate values with infinity as a possible value, so used 100 as max
		//can adapt maxes based on expected gameplay
		
		//returns the boredom of the player
		public function getBoredom():Number 
		{
			//differences measure how much player has of "X" versus what is optimal amount of "X" for boredom
			var ammoDifference:Number = 100 - this.ammo;
			var healthDifference:Number = 100 - this.healthness;
			var killsDifference:Number = this.kills - 0;
			var zombiesDifference:Number = this.visibleZombies - 0;
			//difference between optimal boredom and player's values
			this.boredom = 400 - ammoDifference - healthDifference - killsDifference - zombiesDifference;
			//normlaizing boredom
			this.boredom = (this.boredom / 400) * 100;
			return this.boredom;
		}
		
		//returns the excitement of the player
		public function getExcitement():Number 
		{
			//differences measure how much player has of "X" versus what is optimal amount of "X" for excitement
			var killsDifference:Number = 100 - this.kills;
			var zombiesDifference:Number = 100 - this.visibleZombies;
			var timesHurtDifference:Number = this.timesHurt - 0;
			//difference between optimal excitement and player's values
			this.excitement = 300 - killsDifference - zombiesDifference - zombiesDifference;
			//normalizing excitement
			this.excitement = (this.excitement / 300) * 100;
			return this.excitement;
		}
		
		//retuns the stress of the player
		public function getStress():Number 
		{
			//differences measure how much player has of "X" versus what is optimal amount of "X" for stress
			var zombiesDifference:Number = 100 - this.visibleZombies;
			var timesHurtDifference:Number = 100 - this.timesHurt;
			var healthDifference:Number = this.healthness - 0;
			var ammoDifference:Number = this.ammo - 0;
			//difference between optimal stress and player's values
			this.stress = 400 - zombiesDifference - timesHurtDifference - healthDifference - ammoDifference;
			//normlaizing stress
			this.stress = (this.stress / 400) * 100;
			return this.stress;
		}
		
		//returns health of associated player
		public function getHealth():Number 
		{
			return this.healthness;
		}
		
		//returns ammo of associated player
		public function getAmmo():Number 
		{
			return this.ammo;
		}
		
		//returns kills of associated players
		public function getKills():Number 
		{
			return this.kills;
		}
		
		//returns number of times hurt of associated player
		public function getTimesHurt():Number 
		{
			return this.timesHurt;
		}
		
		//returns number of zombies visible to player
		public function getVisibleZombies():Number 
		{
			return this.visibleZombies;
		}
	}

}