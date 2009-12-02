package com.dungeonizer
{
  import flash.events.*;
  public class VictoryEvent extends Event
  {
    public var entity : Entity;
    public function VictoryEvent(type : String, e : Entity)
    {
      super(type, true, true);
      entity = e;
    }
  }
}