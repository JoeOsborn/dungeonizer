package com.dungeonizer
{
	public class Entity 
	{
	  public var map : Map;
	  
	  public var size : Number;
	  public var sightRadius : Number;
	  
	  public var position : Vec;
	  public var forward : Vec;
	  public var side : Vec;
	  public var up : Vec;
	  public var velocity : Vec;
	  public var max_force : Number;
	  public var max_speed : Number;
	  
	  public var steering_direction : Vec;
	  
	  public var target : Vec;
	  
	  public function Entity(
	    px : Number, py : Number, 
	    sz : Number, interestRadius : Number, 
	    speed : Number, 
	    mp : Map)
	  {
	    position = new Vec(px, py, 0);
	    forward = new Vec(1, 0, 0);
	    side = new Vec(0, 0, 1);
	    up = new Vec(0, 1, 0);
	    velocity = new Vec( 0,  0, 0);
	    max_force = 2.0;
	    max_speed = speed;
	    size = sz;
	    sightRadius = interestRadius;
	    map = mp;
	  }
	  public function get x() : Number
	  {
	    return position.x;
	  }
	  public function get y() : Number
	  {
	    return position.y;
	  }
	  public function get mass() : Number
	  {
	    return size;
	  }
	  public function setTarget(px : Number, py : Number) : void
	  {
	    target = new Vec(px, py, 0);
	  }
	  public function steer() : void
	  {
	    var desired_velocity : Vec = ((target.subtract(position)).normalize()).multiplyScalar(max_speed);
      steering_direction = desired_velocity.subtract(velocity);
	  }
	  public function wouldCollideAt(pt : Vec) : Boolean
	  {
	    //check for walls within this box; do a real check for each of them
	    var left : Number = pt.x - size;
	    var right : Number = pt.x + size;
	    var bottom : Number = pt.y - size;
	    var top : Number = pt.y + size;
	    for (var i : Number = left-1; i <= right+1; i++)
	    {
	      for (var j : Number = bottom-1; j <= top+1; j++)
	      {
	        if(map.cellAtXY(Math.floor(i),Math.floor(j)) == map.WALL)
	        {
	          var dx : Number = i - pt.x;
	          var dy : Number = j - pt.y;
	          if(Math.sqrt(dx*dx + dy*dy) <= size+0.8) //fudge the size up a little bit to prevent corner cases
	          {
	            return true;
	          }
	        }
	      }
	    }
	    return false;
	  }
	  public function update(dt : Number) : void
	  {
	    steer();
	    
	    if(steering_direction.isNonZero()) 
	    {
  	    var steering_force : Vec = steering_direction.truncate(max_force);
        var acceleration : Vec = steering_force.divideScalar(mass).multiplyScalar(dt);
        velocity = (velocity.add(acceleration)).truncate(max_speed);
	    }
	    
      //is the new position a wall? if so, only slide
      if(wouldCollideAt(new Vec(position.x+velocity.x, position.y, position.z)))
      {
        velocity.x = 0;
      }
      if(wouldCollideAt(new Vec(position.x, position.y+velocity.y, position.z)))
      {
        velocity.y = 0;
      }
      if(wouldCollideAt(new Vec(position.x, position.y, position.z+velocity.y)))
      {
        velocity.z = 0;
      }
      position = position.add(velocity);
      
      var new_forward : Vec = velocity.normalize();
      var new_side : Vec = new_forward.cross(up);      
      forward = new_forward;
      side = new_side;
      
	  }
	}
}