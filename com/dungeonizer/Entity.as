package com.dungeonizer
{
	public class Entity 
	{
	  private var size : Number;
	  private var sightRadius : Number;
	  
	  private var position : Vec;
	  private var forward : Vec;
	  private var side : Vec;
	  private var up : Vec;
	  private var velocity : Vec;
	  private var max_force : Number;
	  private var max_speed : Number;
	  
	  private var steering_direction : Vec;
	  
	  private var target : Vec;
	  
	  public function Entity(
	    px : Number, py : Number, 
	    sz : int, interestRadius : int, 
	    speed : Number, 
	    map : Map)
	  {
	    position = new Vec(px, py, 0);
	    forward = new Vec(1, 0, 0);
	    side = new Vec(0, 0, 1);
	    up = new Vec(0, 1, 0);
	    velocity = new Vec( 0,  0, 0);
	    max_force = 1;
	    max_speed = speed;
	    size = sz;
	    sightRadius = interestRadius;
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
	  public function update(dt : Number) : void
	  {
	    steer();
	    
      trace("steering towards " + steering_direction);
	    if(steering_direction.isNonZero()) 
	    {
  	    var steering_force : Vec = steering_direction.truncate(max_force);
        var acceleration : Vec = steering_force.divideScalar(mass).multiplyScalar(dt);
        trace("accelerating by " + acceleration);
        velocity = (velocity.add(acceleration)).truncate(max_speed);
	    }
	    
      trace("vel is " + velocity);
      position = position.add(velocity);

      trace("pos: " + position);

      var new_forward : Vec = velocity.normalize();
      var new_side : Vec = new_forward.cross(up);      
      forward = new_forward;
      side = new_side;
      
	  }
	}
}