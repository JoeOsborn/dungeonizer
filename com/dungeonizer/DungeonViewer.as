﻿package com.dungeonizer{	import flash.display.MovieClip;	import flash.events.TimerEvent;	import flash.utils.Timer;	public class DungeonViewer extends MovieClip {		private var dungeon:Dungeon;		private var timer:Timer;		private var viewers:Array;		public var showGrid:Boolean;		public function DungeonViewer(d : Dungeon) {			super();			dungeon=d;			timer=new Timer(1000.0/30.0);			timer.addEventListener(TimerEvent.TIMER, timerHandler);			showGrid=false;			timer.start();			viewers = new Array();		}		public function timerHandler(e : TimerEvent):void {			graphics.clear();			if (showGrid) {				displayMap();			}			displayEntities();		}		public function displayMap():void {			//graphics.lineStyle(1,0x333333,1);			var tr:Number=Dungeon.TILE_RATIO;			var map:Map=dungeon.map;			for (var i:int = 0; i < Map.WIDTH; i++) {				for (var j:int = 0; j < Map.HEIGHT; j++) {					var nx:Number=i*tr;					var ny:Number=j*tr;					graphics.moveTo(nx,ny);					if (map.cellAtXY(i,j)==map.FLOOR) {						graphics.beginFill(0xFFFFFF,0.3);					} else {						graphics.beginFill(0x333333,0.3);					}					graphics.lineTo(nx+9,ny);					graphics.lineTo(nx+9,ny+9);					graphics.lineTo(nx,ny+9);				}			}		}		public function displayEntities():void {			var tr:Number=Dungeon.TILE_RATIO;			graphics.lineStyle(1,0xEE3333,1);			/*for each (var e : Entity in dungeon.entities)			{			  var nx : Number = (e.x) * tr;			  var ny : Number = (e.y) * tr;			  var ns : Number = e.size * tr;			  graphics.beginFill(0xEE3333,1);			  graphics.drawCircle(nx, ny, ns);			  graphics.endFill();			  var m : Monster = e as Monster;			  if(m != null)			  {			    graphics.drawCircle(nx, ny, m.sightRadius*tr);			  }			}*/			for each (var v:EntityViewer in viewers) {				if (v.entity==null||v.entity.dead) {					if (v.clip.parent!=null) {						v.clip.parent.removeChild(v.clip);					}				} else {					var nx : Number = (v.entity.x) * tr;					var ny : Number = (v.entity.y) * tr;					v.clip.x=nx;					v.clip.y=ny;					var p:Player=v.entity as Player;					if (p!=null) {						if (p.justSlashed) {							var angle=p.facing;							//hack, magic numbers							var sx=Math.cos(angle)*Player.SLASH_DISTANCE*5;							var sy=Math.sin(angle)*Player.SLASH_DISTANCE*5;							var slashClip:MovieClip;							if (p._slashType==Entity.CATEGORY_PRINCESS) {								slashClip = new FlowerClip();							} else if (p._slashType == Entity.CATEGORY_MONSTER || p._slashType == Entity.CATEGORY_NONE) {								slashClip = new SwordClip();							}							slashClip.x=sx;							slashClip.y=sy;							if (sy>0) {								slashClip.scaleY=-1;							}							if (sx<0) {								slashClip.scaleX=-1;							}							v.clip.addChild(slashClip);						}					}				}			}		}		public function addEntityViewer(viewer:EntityViewer) {			viewers.push(viewer);			addChild(viewer.clip);		}	}}