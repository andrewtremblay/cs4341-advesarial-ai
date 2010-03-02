package  
{
	
	import org.flixel.*;
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
		function getBoredom():Number;
		function getExcitement():Number;
		function getStress():Number;
		function getHealth():Number;
		function getAmmo():Number;
		function getKills():Number;
		function getTimesHurt():Number;
		function getVisibleZombies():Number;
	}

}