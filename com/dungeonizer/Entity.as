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
	  
	  public var steering_direction : Vec;
	  
	  public var wandering : Boolean;
	  public var target : Vec;
	  public var targetEntity : Entity;
	  
	  public var full_max_speed : Number;
	  
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
	    size = sz;
	    sightRadius = interestRadius;
	    map = mp;
	    targetEntity = null;
	    full_max_speed = speed;
	    steering_direction = new Vec(0, 0, 0);
	    wander();
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
	    if(wandering)
	    {
	      return full_max_speed/2.0;
	    }
	    return full_max_speed;
	  }
	  public function get max_force() : Number
	  {
	    if(wandering)
	    {
	      return 5.0;
	    }
	    return 10.0;
	  }
	  public function setTargetEntity(e : Entity) : void
	  {
	    targetEntity = e;
	    updateTarget();
	  }
	  private function updateTarget() : void
	  {
	    if(targetEntity != null)
	    {
  	    setTarget(targetEntity.x, targetEntity.y);
	    }
	  }
	  public function wander() : void
	  {
	    target = new Vec(x + (Math.random() - 0.5)*10, y + (Math.random() - 0.5)*10, 0);
	    wandering = true;
	  }
	  public function setTarget(px : Number, py : Number) : void
	  {
	    var newTarget : Vec = new Vec(px, py, 0);
	    if(newTarget.subtract(position).magnitude() <= sightRadius)
	    {
	      target = newTarget;
	      wandering = false;
	    }
	    else
	    {
	      wander();
	    }
	  }
	  public function steer() : void
	  {
	    if(target == null)
	    {
	      return;
	    }
      var slowing_distance : Number = 5;
      var target_offset : Vec = target.subtract(position);
      var distance : Number = target_offset.magnitude();
      var ramped_speed : Number = max_speed * (distance / slowing_distance);
      var clipped_speed : Number = Math.min(ramped_speed, max_speed);
      var desired_velocity : Vec = target_offset.multiplyScalar(clipped_speed / distance);
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
	    updateTarget();
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
      if(wouldCollideAt(new Vec(position.x+velocity.x, position.y+velocity.y, position.z)))
      {
        velocity.x = 0;
        velocity.y = 0;
      }
/*      if(wouldCollideAt(new Vec(position.x, position.y, position.z+velocity.z)))
      {
        velocity.z = 0;
      }
*/
      position = position.add(velocity);
      
      var new_forward : Vec = velocity.normalize();
      var new_side : Vec = new_forward.cross(up);      
      forward = new_forward;
      side = new_side;
      
	  }
	}
}