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
		
		private static const BG_COLOR = 0xEDEDED;
		
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
		
		public function DrawingCanvasUI(barWidth:Number, barHeight:Number)
		{
			super();
			
			var cx:Number = 150;
			var cy = 18;
			_buttons = new Array();
			_activePallet = FLOOR;
			
			//draw background
			graphics.lineStyle(0,0x00000,0);
			graphics.beginFill(BG_COLOR,1);
			graphics.lineTo(barWidth,0);
			graphics.lineTo(barWidth,barHeight);
			graphics.lineTo(0,barHeight);
			//graphics.lineTo(0,0);
			
			//adding floorbutton
			_floorButton = new FloorPalletBoxClip();
			_buttons[FLOOR] = _floorButton;
	
			//adding wallbutton
			_wallButton = new WallPalletBoxClip();
			_buttons[WALL] = _wallButton;
		
			//adding monsterButton
			_monsterButton = new MonsterBoxClip();
			_buttons[MONSTER] = _monsterButton;
			
			//adding princessButton
			_princessButton = new PrincessBoxClip();
			_buttons[PRINCESS] = _princessButton;
	
			//adding redbutton
			_redButton = new RedPalletBoxClip();
			_buttons[RED] = _redButton;
			
			//adding greenButton
			_greenButton = new GreenPalletBoxClip();
			_buttons[GREEN] = _greenButton;

			//adding floorbutton
			_blueButton = new BluePalletBoxClip();
			_buttons[BLUE] = _blueButton;
			
			//adding floorbutton
			_blackButton = new BlackPalletBoxClip();
			_buttons[BLACK] = _blackButton;
			
			
			
			//_blackButton.addEventListener(MouseEvent.ROLL_OVER,handleRollOver);
			//_blackButton.addEventListener(MouseEvent.ROLL_OUT,handleRollOut);
			
			for(var i in _buttons){
				_buttons[i].x = cx;
				_buttons[i].y = cy;
				addChild(_buttons[i]);
				cx += _buttons[i].width + SPACER;
				
				_buttons[i].addEventListener(MouseEvent.ROLL_OVER, handleRollOver);
				_buttons[i].addEventListener(MouseEvent.ROLL_OUT, handleRollOut);
			}
			
			hideAll();

			
		}
		
		public function handleMouseDown(ev:MouseEvent){
			activatePallet(ev.stageX,ev.stageY);
		}
		
		private function activatePallet(x:Number,y:Number){

			//trace(x+" "+y);
			for(var i in _buttons){
				if(_buttons[i].hitTestPoint(x,y,true)){
					_activePallet = i;
					hideAll();
					_buttons[_activePallet].alpha = 1;
					//trace("active: "+_activePallet);
				}
			}
			
		}
		public function get activePallet():int{
			return _activePallet;
		}
		
		private function hideAll(){
			for(var i in _buttons){
				_buttons[i].alpha = .5;
			}
		}
		
		private function handleRollOver(ev:MouseEvent){
			ev.target.alpha = 1;
		}
		
		private function handleRollOut(ev:MouseEvent){
			if(!(ev.target === _buttons[_activePallet])){
				ev.target.alpha = .5;
			}
		}
	}
}