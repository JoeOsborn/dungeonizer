package com.dungeonizer
{
	public class Player extends Entity
	{
	  public function Player(
	    px : Number, py : Number, 
	    sz : Number, speed : Number, 
	    mp : Map)
	  {
	    super(px, py, sz, speed, mp);
	  }
	}
}