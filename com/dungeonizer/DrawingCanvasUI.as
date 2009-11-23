package com.dungeonizer
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class DrawingCanvasUI extends Sprite
	{
		public static const FLOOR:int = 	0;
		public static const WALL:int = 		1;
		public static const MONSTER:int = 	2;
		public static const PRINCESS:int = 	3;
		public static const RED:int = 		4;
		public static const GREEN:int = 	5;
		public static const BLUE:int = 		6;
		public static const BLACK:int = 	7;
		
		
		public const SPACER:Number = 10;
		
		private var _floorButton:MovieClip;
		private var _wallButton:MovieClip;
		private var _monsterButton:MovieClip;
		private var _princessButton:MovieClip;
		private var _redButton:MovieClip;
		private var _greenButton:MovieClip;
		private var _blueButton:MovieClip;
		private var _blackButton:MovieClip;
		
		private var _buttons:Array;
		
		private var _activePallet:int;
		
		public function DrawingCanvasUI()
		{
			super();
			
			var cx:Number = 0;
			_buttons = new Array();
			_activePallet = FLOOR;
			
			//adding floorbutton
			_floorButton = new FloorPalletBoxClip();
			_floorButton.x = cx;
			addChild(_floorButton);
			cx += _floorButton.width + SPACER;
			_buttons[FLOOR] = _floorButton;
			
			
			//adding wallbutton
			_wallButton = new WallPalletBoxClip();
			_wallButton.x = cx;
			addChild(_wallButton);
			cx += _wallButton.width + SPACER;
			_buttons[WALL] = _wallButton;
			
			//adding monsterButton
			_monsterButton = new MonsterBoxClip();
			_monsterButton.x = cx;
			addChild(_monsterButton);
			cx += _monsterButton.width + SPACER;
			_buttons[MONSTER] = _monsterButton;
			
			//adding princessButton
			_princessButton = new PrincessBoxClip();
			_princessButton.x = cx;
			addChild(_princessButton);
			cx += _princessButton.width + SPACER;
			_buttons[PRINCESS] = _princessButton;
			
			//adding redbutton
			_redButton = new RedPalletBoxClip();
			_redButton.x = cx;
			addChild(_redButton);
			cx += _redButton.width + SPACER;
			_buttons[RED] = _redButton;
			
			//adding greenButton
			_greenButton = new GreenPalletBoxClip();
			_greenButton.x = cx;
			addChild(_greenButton);
			cx += _greenButton.width + SPACER;
			_buttons[GREEN] = _greenButton;
			
			//adding floorbutton
			_blueButton = new BluePalletBoxClip();
			_blueButton.x = cx;
			addChild(_blueButton);
			cx += _blueButton.width + SPACER;
			_buttons[BLUE] = _blueButton;
			
			//adding floorbutton
			_blackButton = new BlackPalletBoxClip();
			_blackButton.x = cx;
			addChild(_blackButton);
			cx += _blackButton.width + SPACER;
			_buttons[BLACK] = _blackButton;
			

			
		}
		
		public function handleMouseDown(ev:MouseEvent){
			var tx = ev.localX - x;
			var ty = ev.localY - y;
			activatePallet(tx,ty);
		}
		
		private function activatePallet(x:Number,y:Number){
			var bwidth = width / _buttons.length;
			_activePallet = int(x /bwidth);
			
			/*for(var i in _buttons){
				trace(_buttons[i]);
				if(_buttons[i].hitTestPoint(x,y,true)){
					_activePallet = i;
					trace("active: "+_activePallet);
				}
			}*/
			
		}
		public function get activePallet():int{
			return _activePallet;
		}
	}
}