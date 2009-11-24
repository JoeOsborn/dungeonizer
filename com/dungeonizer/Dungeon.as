﻿package com.dungeonizer{  import flash.utils.Timer;  import flash.events.TimerEvent;    public class Dungeon  {    public static const TILE_RATIO : Number = 5;        public var map : Map;    public var entities : Array;    public var player : Player;        private var updateTimer : Timer;    private var lastUpdate : Date;        public function Dungeon()    {      map = new Map();      entities = new Array();      lastUpdate = new Date();      updateTimer = new Timer(1000.0/30.0);      updateTimer.addEventListener(TimerEvent.TIMER, updateHandler);      updateTimer.start();    }    public function addEntity(e : Entity) : void    {      entities.push(e);      e.dungeon = this;    }    public function removeEntity(e : Entity) : void    {      entities.splice(entities.indexOf(e), 1);      if(e == player)      {        player = null;      }    }    public function addMonster(m : Monster) : void    {      addEntity(m);      m.setTargetEntity(player);    }    public function slashOthers(e : Entity, st : int, off : Number, r : Number) : void    {      var angle : Number = e.facing;      var scx = e.position.x + off * Math.cos(angle);      var scy = e.position.y + off * Math.sin(angle);	    trace("slashing at angle " + angle + "; x: " + scx + "; y: " + scy);      for each(var ent : Entity in entities)      {        if(ent.isSlashedBy(e, st, scx, scy, r))        {          ent.slashedBy(e, scx, scy);        }      }    }        public function closestEntity(e:Entity) : Entity    {      var minDist : Number = map.HEIGHT * map.WIDTH;      var closest : Entity = null;      for each(var ent : Entity in entities)      {        if(ent != e)        {          var distance : Number = (ent.position.subtract(e.position)).magnitude();          if(distance < minDist)          {            minDist = distance;            closest = ent;          }        }      }      return closest;    }        private function updateHandler(t : TimerEvent) : void    {      var dt : Number = (new Date()).time - lastUpdate.time;      for each(var e : Entity in entities)      {        //trace("updating e " + e);        e.update(dt/1000);      }      lastUpdate = new Date();    }        public function setupEntityTest() : void    {/*      map.setBox(map.FLOOR, 9,27, 9, 6);      map.setBox(map.FLOOR, 9,18, 9, 6);      map.setBox(map.FLOOR, 3, 6, 6,27);      map.setBox(map.FLOOR, 9, 6,18, 6);      map.setBox(map.FLOOR,27, 6, 6,27);*/            /*      for(var cy : int = 0; cy < map.HEIGHT; cy++)      {        var line : String = "";        for(var cx : int = 0; cx < map.WIDTH; cx++)        {          line += new String(map.cellAtXY(cx, cy));          line += " ";        }        trace(line);      }      */      map.setBox(map.FLOOR, 5, 50, 20, 20);      map.setBox(map.FLOOR, 135, 50, 20, 20);      player = new Player(map, 10, 60);      addEntity(player);      var follower : Monster = new Monster(map, 15, 60,  4.0);      addMonster(follower);    }          }}