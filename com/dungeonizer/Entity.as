package com.dungeonizer
{
	public class Entity 
	{
	  public var map : Map;
	  
	  public var size : Number;
	  
	  public var position : Vec;
	  public var forward : Vec;
	  public var side : Vec;
	  public var up : Vec;
	  public var velocity : Vec;	  

	  public var full_max_speed : Number;

	  public function Entity(
	    px : Number, py : Number, 
	    sz : Number,
	    speed : Number, 
	    mp : Map)
	  {
	    position = new Vec(px, py, 0);
	    forward = new Vec(1, 0, 0);
	    side = new Vec(0, 0, 1);
	    up = new Vec(0, 1, 0);
	    size = sz;
	    full_max_speed = speed;
	    velocity = new Vec(0,0,0);
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
	  public function get max_speed() : Number
	  {
	    return full_max_speed;
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
	          if(Math.sqrt(dx*dx + dy*dy) <= size) //fudge the size up a little bit to prevent corner cases
	          {
	            return true;
	          }
	        }
	      }
	    }
	    return false;
	  }
	  public function updateVelocity(dt : Number) : void
	  {
      //is the new position a wall? if so, only slide
      var multV : Vec = velocity.multiplyScalar(dt);
      if(velocity.x != 0 && wouldCollideAt(new Vec(position.x+multV.x, position.y, position.z)))
      {
        velocity.x = 0;
      }
      if(velocity.y != 0 && wouldCollideAt(new Vec(position.x, position.y+multV.y, position.z)))
      {
        velocity.y = 0;
      }
      if(velocity.x != 0 && velocity.y != 0 && wouldCollideAt(new Vec(position.x+multV.x, position.y+multV.y, position.z)))
      {
        velocity.x = 0;
        velocity.y = 0;
      }
	  }
	  public function updatePosition(dt : Number) : void
	  {
	    position = position.add(velocity.multiplyScalar(dt));
	  }
	  public function updateOrientation(dt : Number) : void
	  {
	    var new_forward : Vec = velocity.normalize();
      var new_side : Vec = new_forward.cross(up);      
      forward = new_forward;
      side = new_side;
	  }
	  public function update(dt : Number) : void
	  {
	    updateVelocity(dt);
	    updatePosition(dt);
      updateOrientation(dt);
	  }	  
	}
}