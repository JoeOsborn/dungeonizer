package com.dungeonizer
{
	public class Player extends Entity
	{
	  public var movement : Object;
	  public function Player(
	    px : Number, py : Number, 
	    sz : Number, speed : Number, 
	    mp : Map)
	  {
	    super(px, py, sz, speed, mp);
	    movement = {"left":false, "right":false, "up":false, "down":false};
	  }
	  public override function updateVelocity(dt : Number) : void
	  {
      //left vs up vs right vs down
      if(movement["left"] && movement["right"])
      {
        velocity.x = 0;
      }
      else if(movement["left"])
      {
        velocity.x = -max_speed;
      }
      else if(movement["right"])
      {        
        velocity.x = max_speed;
      }
      else
      {
        velocity.x = 0;
      }
      if(movement["up"] && movement["down"])
      {
        velocity.y = 0;
      }
      else if(movement["up"])
      {
        velocity.y = -max_speed;
      }
      else if(movement["down"])
      {
        velocity.y = max_speed;
      }
      else
      {
        velocity.y = 0;
      }
	    super.updateVelocity(dt);
	  }
	}
}