﻿package com.dungeonizer{	public class Entity 	{			  static const CATEGORY_NONE : int = 0;	  static const CATEGORY_MONSTER : int = 1;	  static const CATEGORY_PRINCESS : int = 2;	  static const CATEGORY_PLAYER : int = 3;	  	  public var slashForce : Number;	  	  public var health : int;	  public var maxHealth : int;	  public var map : Map;	  public var dungeon : Dungeon;	  	  public var size : Number;	  	  public var position : Vec;	  public var forward : Vec;	  public var side : Vec;	  public var up : Vec;	  public var velocity : Vec;	  	  public var full_max_speed : Number;	  	  public var category : int;	  	  private var hitTimer : Number;	  private var hitRecovery : Number;	  	  public var followers : Array;	  	  public var dead:Boolean;	  	  public function Entity(	    mp : Map,	    px : Number, py : Number, 	    sz : Number,	    speed : Number)	  {	    followers = new Array();	    category = CATEGORY_NONE;	    maxHealth = int(sz);	    health = maxHealth;	    hitTimer = 0;	    hitRecovery = 0.5;		  slashForce = 20.0;	    position = new Vec(px, py, 0);	    forward = new Vec(1, 0, 0);	    side = new Vec(0, 0, 1);	    up = new Vec(0, 1, 0);	    size = sz;	    full_max_speed = speed;	    velocity = new Vec(0,0,0);	    map = mp;	    dead = false;	  }	  public function addFollower(e : Entity) : void	  {	    followers.push(e);	  }	  public function removeFollower(e : Entity) : void	  {	    followers.splice(followers.indexOf(e), 1);	  }	  public function get facing() : Number	  {	    var angle : Number = forward.toAngle();      if(angle >= (-Math.PI/4) && angle <= (Math.PI / 4))      {        angle = 0;      }      if(angle >= (Math.PI/4) && angle <= (3*Math.PI / 4))      {        angle = Math.PI/2;      }      if(angle >= (3*Math.PI / 4) && angle <= (-3*Math.PI/4))      {        angle = Math.PI;      }      if(angle >= (-3*Math.PI/4) && angle <= (-Math.PI/4))      {        angle = -Math.PI/2;      }      return angle;	  }	  public function get x() : Number	  {	    return position.x;	  }	  public function get y() : Number	  {	    return position.y;	  }	  public function get mass() : Number	  {	    return size;	  }	  public function get max_speed() : Number	  {	    return full_max_speed;	  }	  protected function slashCategoryAppropriate(e : Entity, st : int) : Boolean	  {	    return st == category;	  }	  public function isSlashedBy(e : Entity, st : int, x : Number, y : Number, r : Number) : Boolean	  {	    if(e == this) { return false; }	    if(hitTimer > 0) { return false; }      var distance : Number = (position.subtract(new Vec(x, y, 0))).magnitude();      if(distance > (r+size)) { return false; }      return slashCategoryAppropriate(e, st);	  }	  public function killedBy(e:Entity) : void	  {  	  	dead = true;	      dungeon.removeEntity(this);	  }	  public function slashedBy(e:Entity, x:Number, y:Number) : void	  {	    var angle : Number = Math.atan2(position.y - e.y, position.x - e.x);	    velocity.x = ((e.slashForce / size)+size) * Math.cos(angle);	    velocity.y = ((e.slashForce / size)+size) * Math.sin(angle);	    health -= 1;	    if(health <= 0)	    {			  killedBy(e);	    }        	  hitTimer = hitRecovery;	    trace("slashed from angle " + angle);	  }	  public function wouldCollideAt(pt : Vec) : Boolean	  {	    //check for walls within this box; do a real check for each of them	    var left : Number = pt.x - size;	    var right : Number = pt.x + size;	    var bottom : Number = pt.y - size;	    var top : Number = pt.y + size;	    for (var i : Number = left-1; i <= right+1; i++)	    {	      for (var j : Number = bottom-1; j <= top+1; j++)	      {	        if(map.cellAtXY(Math.floor(i),Math.floor(j)) == map.WALL)	        {	          var dx : Number = i - pt.x;	          var dy : Number = j - pt.y;	          if(Math.sqrt(dx*dx + dy*dy) <= size + 0.8) //fudge the size up a little bit to prevent corner cases -- this may just be a problem with diagonal movement? not really sure.	          {	            return true;	          }	        }	      }	    }	    return false;	  }	  public function preventWallEntrance(dt : Number) : void	  {      //is the new position a wall? if so, only slide      var multV : Vec = velocity.multiplyScalar(dt);      if(velocity.x != 0 && wouldCollideAt(new Vec(position.x+multV.x, position.y, position.z)))      {        velocity.x = 0;      }      if(velocity.y != 0 && wouldCollideAt(new Vec(position.x, position.y+multV.y, position.z)))      {        velocity.y = 0;      }      if(velocity.x != 0 && velocity.y != 0 && wouldCollideAt(new Vec(position.x+multV.x, position.y+multV.y, position.z)))      {        velocity.x = 0;        velocity.y = 0;      }	  }	  public function updateVelocity(dt : Number) : void	  {	    	  }	  public function updatePosition(dt : Number) : void	  {	    position = position.add(velocity.multiplyScalar(dt));	  }	  public function updateOrientation(dt : Number) : void	  {	    if(velocity.isNonZero())	    {  	    var new_forward : Vec = velocity.normalize();        var new_side : Vec = new_forward.cross(up);              forward = new_forward;        side = new_side;	    }	  }	  public function update(dt : Number) : void	  {	    //don't allow velocity changes when reeling from a hit  	  if(hitTimer > 0)  	  {  	    hitTimer -= dt;  	  }  	  else  	  {  	    updateVelocity(dt);  	  }  	  preventWallEntrance(dt);	    updatePosition(dt);      updateOrientation(dt);	  }	  	}}