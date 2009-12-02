﻿package{	import com.dungeonizer.DrawingCanvas;	import com.dungeonizer.DrawingCanvasUI;	import com.dungeonizer.Dungeon;	import com.dungeonizer.DungeonViewer;	import com.dungeonizer.EntityViewer;	import com.dungeonizer.Player;		import flash.display.Sprite;	import flash.events.*;	public class TheDungeonizer extends Sprite	{				public var dungeon : Dungeon;		private var dungeonViewer : DungeonViewer;		private var drawingCanvas:DrawingCanvas;		private var drawingUI:DrawingCanvasUI;		private var touchArea:Sprite;		public function TheDungeonizer()		{			super();			dungeon = new Dungeon();									drawingUI = new DrawingCanvasUI(800,80);			drawingUI.y = 600;			dungeonViewer = new DungeonViewer(dungeon);			drawingCanvas = new DrawingCanvas(dungeon, dungeonViewer, drawingUI);												addChild(drawingCanvas);			addChild(dungeonViewer);			addChild(drawingUI);						setupEntityTest();			drawingCanvas.drawMapState();									  		addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageHandler);		}		public function addedToStageHandler(e : Event) : void		{      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);      stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);            //had to move this stuff here -- flex doesn't initialize the stage variable      //until a thing is added to the stage.			touchArea = new Sprite();			initTouchArea(touchArea);			touchArea.addEventListener(MouseEvent.MOUSE_DOWN,drawingCanvas.handleMouseDown);			touchArea.addEventListener(MouseEvent.MOUSE_MOVE,drawingCanvas.handleMouseMove);			touchArea.addEventListener(MouseEvent.MOUSE_UP,drawingCanvas.handleMouseUp);			drawingUI.addEventListener(MouseEvent.MOUSE_DOWN,drawingUI.handleMouseDown);			addChild(touchArea);		}    public function keyDownHandler(e : KeyboardEvent) : void    {		if(dungeon.player == null) { return; }    	//trace(e.keyCode);      if(e.keyCode == 37)      {        dungeon.player.movement["left"] = true;      }      else if(e.keyCode == 38)       {        dungeon.player.movement["up"] = true;      }      else if(e.keyCode == 39)      {        dungeon.player.movement["right"] = true;      }      else if(e.keyCode == 40)      {        dungeon.player.movement["down"] = true;      }      else if(e.keyCode == 32)      {      	/*if(dungeonViewer.showGrid){      	         dungeonViewer.showGrid = false;      	       } else {      	         dungeonViewer.showGrid = true;      	       }*/      	if(!dungeon.player.slashing)      	{      	  dungeon.player.slashing = true;      	}      } else if(e.keyCode == 16){      	if(dungeonViewer.scaleX == 1){	      	dungeonViewer.scaleX = 2;			dungeonViewer.scaleY = 2;			drawingCanvas.scaleX = 2;			drawingCanvas.scaleY = 2;      	} else {      		dungeonViewer.scaleX = 1.0;			dungeonViewer.scaleY = 1.0;			drawingCanvas.scaleX = 1.0;			drawingCanvas.scaleY = 1.0;      	}      }    }    public function keyUpHandler(e : KeyboardEvent) : void    {		if(dungeon.player == null) { return; }      if(e.keyCode == 37)      {        dungeon.player.movement["left"] = false;      }      else if(e.keyCode == 38)       {        dungeon.player.movement["up"] = false;      }      else if(e.keyCode == 39)      {        dungeon.player.movement["right"] = false;      }      else if(e.keyCode == 40)      {        dungeon.player.movement["down"] = false;      }      else if(e.keyCode == 32)
      {
    	  dungeon.player.slashing = false;
      }    }        private function initTouchArea(area:Sprite) : void {    	area.graphics.lineStyle(1,0x000000,0);    	area.graphics.beginFill(0x000000,0);    	area.graphics.lineTo(stage.stageWidth,0);    	area.graphics.lineTo(stage.stageWidth,600);    	area.graphics.lineTo(0,600);    	area.graphics.lineTo(0,0);    }    private function handleMouseDown(ev:MouseEvent) : void {    	if(ev.stageY > 600){    		trace("hit ui");    	} else {    		drawingCanvas.handleMouseDown(ev);    	}    }    private function handleMouseMove(ev:MouseEvent) : void {    	drawingCanvas.handleMouseMove(ev);    }    private function handleMouseUp(ev:MouseEvent) : void {    	drawingCanvas.handleMouseUp(ev);    }        public function setupEntityTest() : void    {     	 var bc = new BoxClip();      bc.x = 725;      bc.y = 295;      dungeonViewer.addChild(bc);      dungeon.map.setBox(dungeon.map.FLOOR, 5, 50, 20, 20);      dungeon.map.setBox(dungeon.map.FLOOR, 135, 50, 20, 20);      dungeon.player = new Player(dungeon.map, 10, 60);      dungeon.addEntity(dungeon.player);      var playerClip = new HeroClip();       var pe:EntityViewer = new EntityViewer(dungeon.player, playerClip);      pe.clip.gotoAndPlay("right");        dungeonViewer.addEntityViewer(pe,true);                                  } }	}