package com.dungeonizer
{
	import flash.display.MovieClip;

	public class EntityViewer
	{
		private const FRAME_RATE = 1000/24;
		//private var _updateTimer:Timer;
		private var _entity:Entity;
		public var clip:MovieClip;
		public var currentDirection;
		public function EntityViewer(ent:Entity, cp:MovieClip)
		{
			_entity = ent;
			clip = cp;
			currentDirection = 0;
			//_updateTimer = new Timer(FRAME_RATE)
		}
		
		public function get entity():Entity{
			return _entity;
		}
		
	}
}