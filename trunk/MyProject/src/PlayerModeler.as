package  
{
	
	import org.flixel.*;
	/**
	 * ...
	 * @author Kevin Nolan
	 * @author Francis Collins
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
		function getID():Number;
		function getBoredom():Number;
		function getExcitement():Number;
		function getStress():Number;
		function getHealth():Number;
		function getAmmo():Number;
		function getKills():Number;
		function getTimesHurt():Number;
		function getVisibleZombies():Number;
		/*
		 * Does the player modeler handle deltas as well? 
		 * 
		 * function getDeltaBoredom():Number;
		 * function getDeltaExcitement():Number;
		 * function getDeltaStress():Number;
		 * function getDeltaHealth():Number;
		 * function getDeltaAmmo():Number;
		 * function getDeltaKills():Number;
		 * function getDeltaVisibleZombies():Number;
		 * 
		 */
	}

}