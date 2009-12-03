package com.dungeonizer{  import flash.display.MovieClip;  import flash.events.Event;  import flash.events.TimerEvent;  import flash.geom.Point;  import flash.geom.Rectangle;  import flash.utils.Timer;	public class DungeonViewer extends MovieClip	{		public static const PI_2:Number = Math.PI / 2;				public static const SCROLL_LEFT = 350;
		public static const SCROLL_RIGHT = 450;
		public static const SCROLL_UP = 250;
		public static const SCROLL_DOWN = 350;			  private var dungeon : Dungeon;	  private var timer : Timer;	  private var viewers:Array;	  private var playerViewer:EntityViewer;	  private var player:Player;	  private var playerSprites:Object;	  private var health:MovieClip;	  public var showGrid : Boolean;	  		public function DungeonViewer(d : Dungeon)		{			super();			dungeon = d;			timer = new Timer(1000.0/30.0);			timer.addEventListener(TimerEvent.TIMER, timerHandler);						showGrid = false;     		timer.start();     		      		 playerSprites = new Object();     		 viewers = new Array();     		      		 health = new MovieClip();     		 //parent.addChild(health);		}				public function timerHandler(e : TimerEvent) : void		{		  graphics.clear();		  		  if(showGrid){		  	displayMap();		  }		  displayEntities();		}				public function displayMap() : void 		{			//graphics.clear();			//graphics.lineStyle(1,0x333333,1);		  var tr : Number = Dungeon.TILE_RATIO;			var map : Map = dungeon.map;			for(var i:int = 0; i < Map.WIDTH; i++)			{				for(var j:int = 0; j < Map.HEIGHT; j++)				{					var nx:Number = i*tr;					var ny:Number = j*tr;					graphics.moveTo(nx,ny);					if(map.cellAtXY(i,j) == map.FLOOR)					{						graphics.beginFill(0xCCCCCC,0.3);					} 					else 					{						graphics.beginFill(0xFF0000,0.3);					}					graphics.lineTo(nx+9,ny);					graphics.lineTo(nx+9,ny+9);					graphics.lineTo(nx,ny+9);				}			}		}		public function displayEntities() : void 		{		  var tr : Number = Dungeon.TILE_RATIO;			graphics.lineStyle(1,0xEE3333,1);			for each (var v :EntityViewer in viewers){				if(v.entity == null || v.entity.dead){					if(v.clip.parent != null){						v.clip.parent.removeChild(v.clip);					}				} else {					var nx : Number = (v.entity.x) * tr;				 	var ny : Number = (v.entity.y) * tr;				 	v.clip.x = nx;				 	v.clip.y = ny;				 					 	if( v.entity.facing != v.currentDirection) {				 		v.currentDirection = v.entity.facing;				 		if(v.currentDirection == 0){				 			v.clip.gotoAndPlay("right");				 		} else if (v.currentDirection == PI_2){				 			v.clip.gotoAndPlay("down");				 		} else if (v.currentDirection == Math.PI){				 			v.clip.gotoAndPlay("left");				 		} else if (v.currentDirection == -PI_2){				 			v.clip.gotoAndPlay("up");				 		}				 	}				 	var sz : Number = v.entity.size;					var pos : Vec = v.entity.position;				 	for each (var r : Rectangle in v.entity.colliders) {				 	  graphics.drawRect(pos.x*tr+r.x*tr*sz,pos.y*tr+r.y*tr*sz,r.width*tr*sz,r.height*tr*sz);				 	}				}				if(!player.dead){					var plcoord = playerViewer.clip.localToGlobal(new Point(0,0));					//trace(plcoord);					var shiftX = 0;					var shiftY = 0;					if(plcoord.x < SCROLL_LEFT){						shiftX = SCROLL_LEFT - plcoord.x;					} else if(plcoord.x > SCROLL_RIGHT){						shiftX = SCROLL_RIGHT - plcoord.x;					}										if(plcoord.y < SCROLL_UP){						shiftY = SCROLL_UP - plcoord.y;					} else if(plcoord.y > SCROLL_DOWN){						shiftY = SCROLL_DOWN - plcoord.y;					}										if(shiftX != 0 || shiftY != 0){						this.x += shiftX;						this.y += shiftY;				/*		if(this.x > 0){							this.x = 0;						}else if(this.x < 800 - this.width){							this.x = 800 - this.width;						}						if(this.y > 0){							this.y = 0;						} else if(this.y < 680 - this.height){							this.y = 680 - this.height;						}*/						var evt:ShiftEvent = new ShiftEvent(shiftX,shiftY,ShiftEvent.SHIFT);						dispatchEvent(evt);					}										if(player.justSlashed){					 	var angle = player.facing;					 	//hack, magic numbers					 	var sx =Math.cos(angle)*Player.SLASH_DISTANCE*4;					 	var sy =Math.sin(angle)*Player.SLASH_DISTANCE*4;					 	var slashClip:MovieClip;					 	if(player._slashType == Entity.CATEGORY_PRINCESS){					 		slashClip = playerSprites["flower"];					 	} else if(player._slashType == Entity.CATEGORY_MONSTER || player._slashType == Entity.CATEGORY_NONE){					 		slashClip = playerSprites["sword"];					 	}					 	slashClip.x = sx;					 	slashClip.y = sy;					 	if(sy > 0){					 		slashClip.scaleY = -1;					 	} else {					 		slashClip.scaleY = 1;					 	}					 	if (sx < 0){					 		slashClip.scaleX = -1;					 	} else {					 		slashClip.scaleX = 1;					 	}					 	slashClip.visible = true;					 	slashClip.gotoAndPlay(0);					}				}			}		}			public function killedMonster(ve : VictoryEvent) : void
		{
			trace("killed monster");
		}

		public function wooedPrincess(ve : VictoryEvent) : void
		{
			trace("wooed princess");
		}				public function playerHit(ev:Event):void{			updateHealth();
		}
	
		public function addEntityViewer(viewer:EntityViewer, isPlayer:Boolean = false){
			viewers.push(viewer);
			addChild(viewer.clip);
			if(isPlayer){
				playerViewer = viewer;
				player = viewer.entity as Player;
				player.addEventListener("killedMonster", killedMonster);
				player.addEventListener("wooedPrincess", wooedPrincess);
				var flower:MovieClip = new FlowerClip();
				flower.visible = false;
				viewer.clip.addChild(flower);
				playerSprites["flower"] = flower;
					
				var sword:MovieClip = new SwordClip();
				sword.visible = false;
				viewer.clip.addChild(sword);
				playerSprites["sword"] = sword;				player.addEventListener("hit",playerHit);								updateHealth();

			}
		}				public function updateHealth(){			var spacer:Number = 10;			if(parent != null){				try{					parent.removeChild(health);				} catch(er:ArgumentError) {					trace("didn't remove");				}			}			health = new MovieClip();			var cx = 0;			var cy = 0;			for(var i = 1; i <= player.maxHealth; i++){				var heart = new Heart();				heart.x = cx;				heart.y = cy;				if(i <= player.health){					heart.gotoAndStop("full");				} else {					heart.gotoAndStop("empty");				}				cx += heart.width + spacer;				health.addChild(heart);			}			parent.addChild(health);		}	}}