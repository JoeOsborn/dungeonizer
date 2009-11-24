﻿package com.dungeonizer{	public class Player extends Entity	{	  public var movement : Object;	  static const PLAYER_SIZE : Number = 1.0;	  static const PLAYER_SPEED : Number = 7;	  	  static const SLASH_DURATION : Number = 0.5;	  static const SLASH_HURT_START : Number = 0.3;	  static const SLASH_HURT_END : Number = 0.2;	  static const SLASH_RADIUS : Number = 1.0;	  static const SLASH_DISTANCE : Number = PLAYER_SIZE;	  	  private var _slashRequested : Boolean;	  private var _slashPerformed : Boolean;	  private var _slashType : int;	  private var _slashTimer : Number;	  	  private var hitTimer : Number;	  private var hitRecovery : Number;	  	  public function get slashing() : Boolean	  {	    return _slashRequested;	  }	  public function set slashing(v : Boolean) : void	  {	    _slashRequested = v;	  	  }	  	  public function Player(	    mp : Map,	    px : Number, py : Number)	  {	    super(mp, px, py, PLAYER_SIZE, PLAYER_SPEED);	    hitTimer = 0;	    hitRecovery = 0.5;	    maxHealth = 3;	    health = maxHealth;	    category = Entity.CATEGORY_PLAYER;	    movement = {"left":false, "right":false, "up":false, "down":false};	    _slashRequested = false;		_slashTimer = 0;	  }	  public override function slashedBy(e:Entity, x:Number, y:Number) : void	  {	    super.slashedBy(e,x,y);	    hitTimer = hitRecovery;	    _slashTimer = 0;	    //stop playing slash animation	  }	  public override function updateVelocity(dt : Number) : void	  {	    if(hitTimer > 0)	    {	      hitTimer -= dt;	      super.updateVelocity(dt);	      return;	    }      //left vs up vs right vs down      if(movement["left"] && movement["right"])      {        velocity.x = 0;      }      else if(movement["left"])      {        velocity.x = -max_speed;        //play left animation      }      else if(movement["right"])      {                velocity.x = max_speed;        //play right animation      }      else      {        velocity.x = 0;      }      if(movement["up"] && movement["down"])      {        velocity.y = 0;      }      else if(movement["up"])      {        velocity.y = -max_speed;        //play up animation      }      else if(movement["down"])      {        velocity.y = max_speed;        //play down animation      }      else      {        velocity.y = 0;      }	    if(!_slashRequested)	    {	      _slashPerformed = false;	    }      if(_slashRequested && !_slashPerformed)      {        //start slashing        _slashPerformed = true;	      _slashTimer = SLASH_DURATION;	      var closest : Entity = dungeon.closestEntity(this);        var angle : Number = forward.toAngle();	      if(closest.category == Entity.CATEGORY_PRINCESS)	      {	        _slashType = Entity.CATEGORY_PRINCESS;	        //play animation based on angle	      }	      else if(closest.category == Entity.CATEGORY_MONSTER)	      {	        _slashType = Entity.CATEGORY_MONSTER;	        //play animation based on angle	      }	      else	      {	        _slashType = Entity.CATEGORY_NONE;	        //play animation based on angle	      }      }      if(_slashTimer > 0)      {        _slashTimer -= dt;        if(_slashTimer < SLASH_HURT_START && _slashTimer > SLASH_HURT_END)        {          dungeon.slashOthers(this, _slashType, SLASH_DISTANCE, SLASH_RADIUS);        }      }	    super.updateVelocity(dt);	  }	}}