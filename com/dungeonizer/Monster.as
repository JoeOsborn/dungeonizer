package com.dungeonizer
{
	public class Monster extends Entity
	{
	  public var steering_direction : Vec;
	  
	  public var target : Vec;
	  
	  public var wandering : Boolean;
	  public var sightRadius : Number;
	  public var targetEntity : Entity;
	  
	  static const MONSTER_SPEED_FACTOR : Number = 0.0;
	  static const MONSTER_MIN_SPEED : Number = 8;
	  
	  static const MONSTER_MIN_SIGHT : Number = 2.0;
	  static const MONSTER_SIGHT_FACTOR : Number = 3;
	  
	  public function Monster(mp : Map, px : Number, py : Number, sz : Number)
	  {
	    super(mp, px, py, sz, MONSTER_MIN_SPEED+MONSTER_SPEED_FACTOR*sz);
	    category = Entity.CATEGORY_MONSTER;
	    sightRadius = MONSTER_MIN_SIGHT + MONSTER_SIGHT_FACTOR * sz;
	    targetEntity = null;
	    steering_direction = new Vec(0, 0, 0);
	    wander();
	  }
	  public override function get max_speed() : Number
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
	  public function reachedTarget() : Boolean
	  {
	    if(target == null)
	    {
	      return true;
	    }
	    return position.subtract(target).magnitude() <= size;
	  }
	  private function updateTarget() : void
	  {
	    if(targetEntity != null)
	    {
  	    setTarget(targetEntity.x, targetEntity.y);
	    }
	    if(wandering && reachedTarget())
	    {
	      wander();
	    }
	  }
	  public function wander() : void
	  {
      for(var checks : int = 10; checks > 0; checks--)
      {
	      //pick a random reachable square within sight range
	      var sx : Number = x+(Math.random()-0.5)*(sightRadius);
	      var sy : Number = y+(Math.random()-0.5)*(sightRadius);
	      if(!wouldCollideAt(new Vec(sx, sy, position.z)))
	      {
	        target = new Vec(sx, sy, 0);
    	    wandering = true;
    	    break;
	      }
      }
	  }
	  public function setTarget(px : Number, py : Number) : void
	  {
	    var newTarget : Vec = new Vec(px, py, 0);
	    if(newTarget.subtract(position).magnitude() <= sightRadius)
	    {
	      target = newTarget;
	      wandering = false;
	    }
	    else if(!wandering)
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
	  public override function updateVelocity(dt : Number) : void
	  {
      steer();
	    if(steering_direction.isNonZero()) 
	    {
  	    var steering_force : Vec = steering_direction.truncate(max_force);
        var acceleration : Vec = steering_force.divideScalar(mass).multiplyScalar(dt);
        velocity = (velocity.add(acceleration)).truncate(max_speed);
	    }
	    super.updateVelocity(dt);
	  }
	  public override function update(dt : Number) : void
	  {
	    updateTarget();
	    dungeon.slashOthers(this, Entity.CATEGORY_PLAYER, 0, size);
      super.update(dt);
	  }

	}
	
}
	  