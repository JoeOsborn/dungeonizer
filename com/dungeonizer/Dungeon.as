package com.dungeonizer
{
  import flash.utils.Timer;
  import flash.events.TimerEvent;
  
  public class Dungeon
  {
    public var map : Map;
    public var entities : Array;
    
    private var updateTimer : Timer;
    private var lastUpdate : Date;
    
    public function Dungeon()
    {
      map = new Map();
      entities = new Array();
      lastUpdate = new Date();
      updateTimer = new Timer(1000.0/30.0);
      updateTimer.addEventListener(TimerEvent.TIMER, updateHandler);
      updateTimer.start();
    }
    public function addEntity(e : Entity) : void
    {
      entities.push(e);
    }
    private function updateHandler(t : TimerEvent) : void
    {
      var dt : Number = (new Date()).time - lastUpdate.time;
      for each(var e : Entity in entities)
      {
        //trace("updating e " + e);
        e.update(dt/1000);
      }
      lastUpdate = new Date();
    }
    
    public function setupEntityTest() : void
    {
      map.setBox(map.FLOOR, 9,27, 9, 6);
      map.setBox(map.FLOOR, 9,18, 9, 6);
      map.setBox(map.FLOOR, 3, 6, 6,27);
      map.setBox(map.FLOOR, 9, 6,18, 6);
      map.setBox(map.FLOOR,27, 6, 6,27);
      
      /*
      for(var cy : int = 0; cy < map.HEIGHT; cy++)
      {
        var line : String = "";
        for(var cx : int = 0; cx < map.WIDTH; cx++)
        {
          line += new String(map.cellAtXY(cx, cy));
          line += " ";
        }
        trace(line);
      }
      */
      var ent : Entity = new Entity(6.5, 7.5,  1.0,  4,  0.6, map);
      addEntity(ent);
      ent.setTarget(9, 2);
    }
    
    
  }
}