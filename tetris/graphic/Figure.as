package  tetris.graphic
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import tetris.Assets;
	
	/**
	 * ...
	 * @author Vladislav Kozlov <k2v.akosa@gmail.com>
	 */
	public class Figure extends Sprite 
	{
		private var _figureType:int;
		private var _figureVector:Vector.<int>;
		private var _figureBlocks:Array = [];
		private var _figureCoordinates:Array = [];
		private var _x:int;
		private var _y:int;
		private var _size:int;
		private var _widthField:int;
		private var _blockCub:Array = [];
		private var _blockPalka:Array = [];
		private var _blockZleft:Array = [];
		private var _blockZright:Array = [];
		private var _blockT:Array = [];
		private var _blockL:Array = [];
		private var _blockG:Array = [];	
		private var _blocksFigures:Array = [];
		private var _blockBitmaps:Array = [];	
		private var _blockRect:Array = [];
		private var _blockGBig:Array = [];
		private var _blockLBig:Array = [];	
		private var _arrayShapeFigure:Array = [];
		private var _blockFigure:Array = [];
		private var _arrayBlocksBitmaps:Array = [];	
		private var _blockCubeBD:BitmapData;
		private var _blockPalkaBD:BitmapData;
		private var _blockZleftBD:BitmapData;
		private var _blockZrightBD:BitmapData;
		private var _blockTBD:BitmapData;
		private var _blockLBD:BitmapData;
		private var _blockGBD:BitmapData;	
		private var _blockBD:BitmapData;
		private var _blockRectBD:BitmapData;
		private var _blockGBigBD:BitmapData;
		private var _blockLBigBD:BitmapData;	
		private var _blocksLength:int;
		private var _figureBlockInit:Boolean = false;
		private var _tetrisCont:DisplayObjectContainer;
		
		public function Figure(gameContainer:DisplayObjectContainer, size:int, width:int)
		{
			_tetrisCont = gameContainer;
			_size = size;
			_widthField = width;
			
			for (var k:int = 0; k < 10; k++)
			{
				_arrayBlocksBitmaps = new Array();
				_blocksFigures[k] = _arrayBlocksBitmaps; 
			}
			
			var blockCub:Bitmap = new Bitmap();
			blockCub = Assets.shape1;
			_blockCubeBD = blockCub.bitmapData;	
			var blockPalka:Bitmap = new Bitmap();
			blockPalka = Assets.shape7;
			_blockPalkaBD = blockPalka.bitmapData;		
			var blockZleft:Bitmap = new Bitmap();
			blockZleft = Assets.shape3;
			_blockZleftBD = blockZleft.bitmapData;		
			var blockZright:Bitmap = new Bitmap();
			blockZright = Assets.shape4;
			_blockZrightBD = blockZright.bitmapData;			
			var blockT:Bitmap = new Bitmap();
			blockT = Assets.shape2;
			_blockTBD = blockT.bitmapData;		
			var blockL:Bitmap = new Bitmap();
			blockL = Assets.shape6;
			_blockLBD = blockL.bitmapData;			
			var blockG:Bitmap = new Bitmap();
			blockG = Assets.shape5;
			_blockGBD = blockG.bitmapData;		
			var blockRect:Bitmap = new Bitmap();
			blockRect = Assets.shape8;
			_blockRectBD = blockRect.bitmapData;		
			var blockGBig:Bitmap = new Bitmap();
			blockGBig = Assets.shape9;
			_blockGBigBD = blockGBig.bitmapData;		
			var blockLBig:Bitmap = new Bitmap();
			blockLBig = Assets.shape10;
			_blockLBigBD = blockLBig.bitmapData;
		}
		
		private function blocksArrayInit(blocks:Array, asset:BitmapData):void
		{
			for (var r:int = 0; r < _blocksLength; r++)
			{
				var block:Bitmap = new Bitmap(asset);
				blocks.push(block);
			}
		}
		
		public function createFigure(figureVector:Vector.<int>, figureType:int, x:int = 0, y:int = 0):void
		{
			var xf:int;
			var yf:int;
			_x = x;
			_y = y;
			
			_figureVector = figureVector;
			_figureType = figureType;
			_blocksLength = _figureVector.length / 2;
			
			figureArrayInit(_figureType, _figureBlocks);
			_figureCoordinates = [];
			
			if (_x ==0 && _y == 0)
			{
				for (var i:int = 0; i < _figureVector.length; i += 2 ) 
				{
					xf =  _widthField + 1 + _figureVector[i];
					yf = 1 + _figureVector[i + 1];
			
					_figureCoordinates[i] = xf * _size;
					_figureCoordinates[i + 1] = yf * _size;
				}
			}
			else
			{
				for (var j:int = 0; j < _figureVector.length; j += 2 ) 
				{
					xf = _x + _figureVector[j];
					yf = _y + _figureVector[j + 1];
			
					_figureCoordinates[j] = xf * _size;
					_figureCoordinates[j + 1] = yf * _size;
				}
			}
			figureDraw(_figureCoordinates, _figureBlocks, _figureVector);
			
			for (var l:int = 0; l < _blocksLength; l++)
			{
				_tetrisCont.addChild(_figureBlocks[l]);
			}
			_figureBlockInit = true;
		}
		
		public function removeFigure():void
		{
			_figureVector = null;
			_figureType = 0;
			
			if (_figureBlockInit)
			{
				for (var r:int = 0; r < _blocksLength; r++)
				{
					_tetrisCont.removeChild(_figureBlocks[r]);
				}
				_figureBlockInit = false;
			}
		}
		
		private function figureDraw(figureCoordinates:Array, arrayFigure:Array, figureVector:Vector.<int>):void
		{
			var xCoordinate:Array = [];
			var yCoordinate:Array = [];
			
			var num:int = 0;
			for (var k:int = 0; k < figureCoordinates.length; k += 2) 
			{
				xCoordinate[num] = figureCoordinates[k];
				yCoordinate[num] = figureCoordinates[k + 1];
				num++;
			}
			for (var j:int = 0; j < _blocksLength; j++)
			{
				arrayFigure[j].x = xCoordinate[j];
				arrayFigure[j].y = yCoordinate[j];
			}	
		}
		
		private function figureArrayInit(typeFigure:int, arrayFigure:Array):void
		{
			function blockBitmapsInit(blockBD:BitmapData):void
			{
				blocksArrayInit(_blockBitmaps, blockBD);
				for (var j:int = 0; j < _blocksLength; j++)
				{
					arrayFigure[j] = _blockBitmaps[j];
				}
			};
			
			if (typeFigure == 0)
			{
				blocksArrayInit(_blocksFigures[0], _blockCubeBD);
				for (var j:int = 0; j < _blocksLength; j++)
				{
					arrayFigure[j] = _blocksFigures[0][j];
				}
			}
			if (typeFigure == 1)
			{
				blocksArrayInit(_blocksFigures[1], _blockPalkaBD);
				for (var l:int = 0; l < _blocksLength; l++)
				{
					arrayFigure[l] = _blocksFigures[1][l];
				}	
			}
			if (typeFigure == 2)
			{
				blocksArrayInit(_blocksFigures[2], _blockZleftBD);
				for (var n:int = 0; n < _blocksLength; n++)
				{
					arrayFigure[n] = _blocksFigures[2][n];
				}
			}
			if (typeFigure == 3)
			{
				blocksArrayInit(_blocksFigures[3], _blockZrightBD);
				for (var r:int = 0; r < _blocksLength; r++)
				{
					arrayFigure[r] = _blocksFigures[3][r];
				}
			}
			if (typeFigure == 4)
			{
				blocksArrayInit(_blocksFigures[4], _blockTBD);
				for (var t:int = 0; t < _blocksLength; t++)
				{
					arrayFigure[t] = _blocksFigures[4][t];
				}
			}
			if (typeFigure == 5)
			{
				blocksArrayInit(_blocksFigures[5], _blockLBD);
				for (var h:int = 0; h < _blocksLength; h++)
				{
					arrayFigure[h] = _blocksFigures[5][h];
				}
			}
			if (typeFigure == 6)
			{
				blocksArrayInit(_blocksFigures[6], _blockGBD);
				for (var w:int = 0; w < _blocksLength; w++)
				{
					arrayFigure[w] = _blocksFigures[6][w];
				}
			}
			
			if (typeFigure == 7)
			{
				blocksArrayInit(_blocksFigures[7], _blockRectBD);
				for (var k:int = 0; k < _blocksLength; k++)
				{
					arrayFigure[k] = _blocksFigures[7][k];
				}
			}
			if (typeFigure == 8)
			{
				blocksArrayInit(_blocksFigures[8], _blockGBigBD);
				for (var i:int = 0; i < _blocksLength; i++)
				{
					arrayFigure[i] = _blocksFigures[8][i];
				}
			}
			if (typeFigure == 9)
			{
				blocksArrayInit(_blocksFigures[9], _blockLBigBD);
				for (var m:int = 0; m < _blocksLength; m++)
				{
					arrayFigure[m] = _blocksFigures[9][m];
				}
			}
		}
	}
}