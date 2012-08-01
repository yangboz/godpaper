/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package flexUnitTests
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.ds.NumberBoard;
	
	import de.polygonal.ds.Array2;
	
	import flexunit.framework.Assert;
	
	/**
	 * NumberBoardTest.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 1, 2012 3:57:00 PM
	 */
	public class NumberBoardTest
	{	
		private var _map:Array2;
		private var _board:NumberBoard;
		//TicTacToe.
		private static const WIDTH:Number = 3;
		private static const HEIGHT:Number = 3;
		private static const NUM_CONNEX:Number = 3;
		
		[Before]
		public function setUp():void
		{
			_map = new Array2(WIDTH,HEIGHT);
			_board = new NumberBoard(WIDTH,HEIGHT,NUM_CONNEX,true,true,true,true);
		}
		
		[After]
		public function tearDown():void
		{
			_map = null;
			_board = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testGet_backwardDiagonalLabels():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertTrue(_board.backwardDiagonalLabels.length);
		}
		
		[Test]
		public function testGet_forwardDiagonalLabels():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertTrue(_board.backwardDiagonalLabels.length);
		}
		
		[Test]
		public function testGetConnex():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertNotNull(_board.getConnex(_map,NUM_CONNEX,null));
		}
		
		[Test]
		public function testHasConnex():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertTrue(_board.hasConnex(WIDTH,HEIGHT,_board.horizontalLabels,NumberBoard.VERTICAL));
		}
		
		[Test]
		public function testGet_horizontalLabels():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertTrue(_board.horizontalLabels.length);
		}
		
		[Test]
		public function testGet_magicWinNumber():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertEquals(_board.magicWinNumber,1<<NUM_CONNEX);
		}
		
		[Test]
		public function testNumberBoard():void
		{
//			Assert.fail("Test method Not yet implemented");
//			Assert.assertEquals(_board.horizontalLabels,[[],[],[],[]]);
			Assert.assertEquals(_board.horizontalLabels.length,NUM_CONNEX);
		}
		
		[Test]
		public function testGet_numOfWinPlaces():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertEquals(_board.numOfWinPlaces,8);//Think about the number of connexs(horizontally,vertically,forwardDiagonally,backwardDiagonally).The answer is 8,right?
		}
		
		[Test]
		public function testToString():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertNotNull(_board.toString());
		}
		
		[Test]
		public function testGet_verticalLabels():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertTrue(_board.verticalLabels.length);
		}
		
		[Test]
		public function testGet_z():void
		{
//			Assert.fail("Test method Not yet implemented");
			Assert.assertEquals(_board.z,8);
		}
	}
}