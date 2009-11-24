﻿package com.dungeonizer{	public class Princess extends Entity	{	  public var steering_direction : Vec;	  	  public var target : Vec;	  	  public var targetEntity : Entity;	  	  	  public var followDistance : Number;	  	  static const PRINCESS_SPEED : Number = Player.PLAYER_SPEED*2;	  	  var tx : Number, ty : Number;	  	  	  	  public function Princess(mp : Map, px : Number, py : Number, sz : Number)	  {	    super(mp, px, py, sz, PRINCESS_SPEED);	    category = Entity.CATEGORY_PRINCESS;	    targetEntity = null;	    tx = px;	    ty = py;	    steering_direction = new Vec(0, 0, 0);	  }	  protected override function slashCategoryAppropriate(e : Entity, st : int) : Boolean	  {	    return super.slashCategoryAppropriate(e, st) || 			   (targetEntity != null && e.category == Entity.CATEGORY_MONSTER);	  }	  public override function isSlashedBy(e : Entity, st : int, x : Number, y : Number, r : Number) : Boolean	  {		if(targetEntity != null && e.category == Entity.CATEGORY_PLAYER)		{			return false;		}		return super.isSlashedBy(e, st, x, y, r);	  }	  public override function killedBy(e:Entity) : void	  {	    if(targetEntity == null && e.category == CATEGORY_PLAYER)	    {  		  setTargetEntity(e);  	      e.addFollower(this);  	      followDistance = e.size;  	      for each(var f : Entity in e.followers)  	      {  	        followDistance += f.size*2 + 1;  	      }  		  followDistance -= size;  		  health = 2;	    }	    else if(targetEntity != null && e.category == CATEGORY_MONSTER)	    {		    tx = x;		    ty = y;			  targetEntity.removeFollower(this);			  health = 2;		      setTargetEntity(null);	    }	  }	  public override function get max_speed() : Number	  {	    return full_max_speed;	  }	  public function get max_force() : Number	  {	    return 60.0;	  }	  public function setTargetEntity(e : Entity) : void	  {	    targetEntity = e;	    updateTarget();	  }	  private function updateTarget() : void	  {	    if(targetEntity != null)	    {	      var facing : Number = targetEntity.facing;	      var distance : Number = followDistance;  	    setTarget(targetEntity.x-distance*Math.cos(facing), targetEntity.y-distance*Math.sin(facing));	    }	    else	    {	      setTarget(tx, ty);	    }	  }	  public function setTarget(px : Number, py : Number) : void	  {      target = new Vec(px, py, 0);	  }	  public function steer() : void	  {      var slowing_distance : Number = 5;      var target_offset : Vec = target.subtract(position);      var distance : Number = target_offset.magnitude();	  if(distance == 0) 	  { 	  	steering_direction = new Vec(0, 0, 0); 		return;	  }      var ramped_speed : Number = max_speed * (distance / slowing_distance);      var clipped_speed : Number = Math.min(ramped_speed, max_speed);      var desired_velocity : Vec = target_offset.multiplyScalar(clipped_speed / distance);      steering_direction = desired_velocity.subtract(velocity);	  }	  public override function updateVelocity(dt : Number) : void	  {      steer();	    if(steering_direction.isNonZero()) 	    {  	    var steering_force : Vec = steering_direction.truncate(max_force);        var acceleration : Vec = steering_force.divideScalar(mass).multiplyScalar(dt);        velocity = (velocity.add(acceleration)).truncate(max_speed);	    }	    super.updateVelocity(dt);	  }	  public override function hitRecovered(dt:Number):void	  {	    velocity.x = 0;	    velocity.y = 0;	  }	  public override function update(dt : Number) : void	  {	    updateTarget();      super.update(dt);	  }	}	}