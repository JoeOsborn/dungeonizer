package com.dungeonizer
{
	import flash.events.Event;

	public class ShiftEvent extends Event
	{
		public static const SHIFT:String = "shift"
		public var shiftX;
		public var shiftY;
		public function ShiftEvent(x:Number, y:Number, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			shiftX = x;
			shiftY = y;
		}
		
	}
}