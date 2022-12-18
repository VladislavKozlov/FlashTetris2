package  tetris.logic
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import tetris.TetrisEvent;
	import tetris.graphic.Field;
	import tetris.graphic.Figure;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class GameLogic 
	{
		private var _width:int; 
		private var _height:int; 
		private var _field:Vector.<Vector.<int>>;		
		private var _type:int;
		private var _angle:int;
		private var _x:int;
		private var _y:int;
		private var _size:int;
		private var _startX:int;
		private var _startY:int;		
		private var _typeNext:int;
		private var _angleNext:int;
		private var _blocksLength:int;
		private var _tetrisCont:DisplayObjectContainer;
		private var _figureGraphic:Figure;
		private var _figureGraphicNew:Figure;
		private var _fieldGraphic:Field;		
		private static var _arrayVectorFigures:Array = [];
		private static const FIGURES:Array = createFigures();
		
		private static function createFigures():Array
		{
			_arrayVectorFigures = FigureParams.createFigures();
			return _arrayVectorFigures;
		}
		
		public function GameLogic(width:int, height:int, size:int, startX:int, startY:int, tetrisContainer:DisplayObjectContainer) 
		{
			_width = width;
			_height = height;
			_tetrisCont = tetrisContainer;
			_size = size;
			_startX = startX;
			_startY = startY;
			
			_field = new Vector.<Vector.<int>>(_height, true);
			for (var y:int = 0; y < _height; y++ ) 
			{
				_field[y] = new Vector.<int>(_width, true);
			}
			
			_figureGraphic = new Figure(_tetrisCont, _size, _width);
			_figureGraphicNew = new Figure(_tetrisCont, _size, _width);
			_fieldGraphic = new Field(_tetrisCont, _height, _width, _size);
		}
		
		public function restart():void
		{
			clearField(); 
			reinitNext(); 
			reinitCurrent();
			reinitNext();
		}
		
		private function clearField():void
		{
			for (var y:int = 0; y < _height; y++ )
			{
				for (var x:int = 0; x < _width; x++ )
				{
					_field[y][x] = 0;
				}
			}
		}
		
		private function reinitNext():void
		{
			_typeNext = FigureParams.createType();
			_angleNext = FigureParams.createAngle();
		}
		
		private function reinitCurrent():void
		{
			_x = _startX;
			_y = _startY;
			_type = _typeNext;
			_angle = _angleNext;
		}
		
		public function reflectCurrentInField():void
		{
			TetrisEvent.dispatch(TetrisEvent.FIGURE_REFLECT_IN_FIELD, this);
			var f:Vector.<int> = FIGURES[_type][_angle] as Vector.<int>;
			for (var i:int = 0; i < f.length; i += 2 )
			{
				_field[f[i + 1] + _y][f[i] + _x] = _type + 1;
			}
		}
		
		private function cantAddNewFigure():Boolean
		{
			return !checkEmpty(_typeNext, _angleNext, 3, 0);
		}
		
		public function newFigure():Boolean
		{
			if (cantAddNewFigure()) return false;
			reinitCurrent();
			reinitNext();
			return true;
		}
		
		public function rotate():Boolean
		{
			var angle:int = (_angle == 3) ? 0 : _angle + 1; 
			var dx:int = 0; 
			var crossing:int;
			while (dx < 4) 
			{
				crossing = checkCrossing(_type, angle, _x + dx, _y);
				if (crossing < 0) return false; 
				if (crossing == 0) {
					_angle = angle;
					_x += dx;
					TetrisEvent.dispatch(TetrisEvent.FIGURE_ROTATE, this);
					return true;
				}
				
				crossing = checkCrossing(_type, angle, _x - dx, _y);
				if (crossing < 0) return false;
				if (crossing == 0) {
					_angle = angle;
					_x -= dx;
					TetrisEvent.dispatch(TetrisEvent.FIGURE_ROTATE, this);
					return true;
				}
				dx++;
			}
			return false;
		}
		
		public function left():Boolean
		{
			if (checkEmpty(_type, _angle, _x - 1, _y)) {
				_x--;
				return true;
			}
			return false;
		}
		
		public function right():Boolean
		{
			if (checkEmpty(_type, _angle, _x + 1, _y)) {
				_x++;
				return true;
			}
			return false;
		}
		
		public function down():Boolean
		{
			if (checkEmpty(_type, _angle, _x, _y + 1)) {
				_y++;
				return true;
			}
			return false;
		}
		
		private function checkEmpty(type:int, angle:int, x:int, y:int):Boolean
		{
			var f:Vector.<int> = FIGURES[type][angle] as Vector.<int>;
			var xf:int;
			var yf:int;
			for (var i:int = 0; i < f.length; i += 2 ) 
			{
				xf = f[i] + x;
				yf = f[i + 1] + y;
				if (xf < 0 || yf < 0 || xf >= _width || yf >= _height || _field[yf][xf]) return false;
			}
			return true;
		}
		
		private function checkCrossing(type:int, angle:int, x:int, y:int):int
		{
			var border:int = 0;
			var filleds:int = 0;
			var f:Vector.<int> = FIGURES[type][angle] as Vector.<int>;
			var xf:int;
			var yf:int;
			for (var i:int = 0; i < f.length; i += 2 ) 
			{
				xf = f[i] + x;
				yf = f[i + 1] + y;
				if (xf < 0 || yf < 0 || xf >= _width || yf >= _height) border++;
				else if (_field[yf][xf]) filleds++;
			}
			return (border) ? border : -filleds;
		}
		
		public function removeFilledLines():int
		{
			var count:int = 0; 
			var line:Vector.<int>; 
			var filled:int; 
			var x:int;
			var y:int = _height - 1;
			while (y > 0) 
			{
				line = _field[y]; 
				filled = 0;
				for (x = 0; x < _width; x++ ) 
					if (line[x])
						filled++;
				
				if (filled == _width) 
				{
					for (x = 0; x < _width; x++ ) line[x] = 0; 
					for (x = y; x >= 1; x-- ) _field[x] = _field[x - 1]; 
					
					_field[0] = line; 
					count++;
				}
				else
				{
					y--;	
				}
			}
			if (count)
			{
				TetrisEvent.dispatch(TetrisEvent.REMOVE_FILLED_LINES, this);
			}
			return count;
		}
		
		public function draw():void
		{
			_fieldGraphic.removeField();
			_figureGraphic.removeFigure();
			_figureGraphicNew.removeFigure();			
			_fieldGraphic.createField(_field);
			
			var figure:Vector.<int> = FIGURES[_type][_angle];
			_figureGraphic.createFigure(figure, _type, _x, _y);		
			figure = FIGURES[_typeNext][_angleNext];
			_figureGraphicNew.createFigure(figure, _typeNext);
		}
	}
}