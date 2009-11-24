
package com.dungeonizer{  import flash.events.TimerEvent;  import flash.utils.Timer;    public class Dungeon  {    public static const TILE_RATIO : Number = 5;        public var map : Map;    public var entities : Array;    public var player : Player;        private var updateTimer : Timer;    private var lastUpdate : Date;        public function Dungeon()    {      map = new Map();      entities = new Array();      lastUpdate = new Date();      updateTimer = new Timer(1000.0/30.0);      updateTimer.addEventListener(TimerEvent.TIMER, updateHandler);      updateTimer.start();    }    public function addEntity(e : Entity) : void    {      entities.push(e);      e.dungeon = this;    }    public function removeEntity(e : Entity) : void    {      entities.splice(entities.indexOf(e), 1);      if(e == player)      {        player = null;      }    }    public function addMonster(m : Monster) : void    {      addEntity(m);      m.setTargetEntity(player);    }    public function slashOthers(e : Entity, st : int, off : Number, r : Number) : void    {      var angle : Number = e.facing;      var scx = e.position.x + off * Math.cos(angle);      var scy = e.position.y + off * Math.sin(angle);      if(e == player)      {  	    trace("slashing at angle " + angle + "\nx: " + scx + "; y: " + scy);      }      for each(var ent : Entity in entities)      {        if(ent.isSlashedBy(e, st, scx, scy, r))        {          ent.slashedBy(e, scx, scy);        }      }    }    public function closeMonster(e:Entity) : Boolean
    {
      for each(var ent : Entity in entities)
      {
        if(ent != e)
        {
          var distance : Number = (ent.position.subtract(e.position)).magnitude();
          if(ent.category == Entity.CATEGORY_MONSTER && distance < 20)
          {
            return true;
          }
        }
      }
      return false;
    }    public function closestEntity(e:Entity) : Entity    {      var minDist : Number = Map.HEIGHT * Map.WIDTH;      var closest : Entity = null;      for each(var ent : Entity in entities)      {        if(ent != e)        {          var distance : Number = (ent.position.subtract(e.position)).magnitude();          if(distance < minDist)          {            minDist = distance;            closest = ent;          }        }      }      return closest;    }        private function updateHandler(t : TimerEvent) : void    {      var dt : Number = (new Date()).time - lastUpdate.time;      for each(var e : Entity in entities)      {        //trace("updating e " + e);        e.update(dt/1000);      }      lastUpdate = new Date();    }              }}
