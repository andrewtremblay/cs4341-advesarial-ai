package  
{
	/**
	 * ...
	 * @author Kevin Nolan
	 */
	/*
	 * 
	 * -Holds the fun metric
	 * -predicts the state of the player
	 * -predictions are considered gospel for the sake of this assignment
	 * -Sends the necessary variables to the AI director.
	 * -outputs readings to console 
	*/
	public interface PlayerModeler
	{
		public function getBoredom():int;
		
		public function getExcitement():int;
		
		public function getStress():int;
		
		public function getHealth():int;
		
		public function getAmmo():int;
		
		//public function getPerceptibility():int;
		
		public function getKills():int;
		
		public function getTimesHurt():int;
		
		public function getZombiesCanSee():int;
	}

}