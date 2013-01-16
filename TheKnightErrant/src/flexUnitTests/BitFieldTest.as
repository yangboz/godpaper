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
	import com.godpaper.as3.utils.BitField;
	
	import flexunit.framework.Assert;
	
	/**
	 * BitFieldTest.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 27, 2012 10:13:07 AM
	 */
	public class BitFieldTest
	{		
		private var _permission:uint = 0<<0;
		private var _bf:BitField = new BitField(_permission);
		[Before]
		public function setUp():void
		{
			// turn these permission to on/true
//			this._bf.set(BitField.PERM_READ);
//			this._bf.set(BitField.PERM_WRITE);
//			this._bf.set(BitField.PERM_ADMIN);
//			this._bf.set(BitField.PERM_ADMIN2);
//			this._bf.set(BitField.PERM_ADMIN3);
		}
		
		[After]
		public function tearDown():void
		{
//			this._bf.clear(BitField.PERM_READ);
//			this._bf.clear(BitField.PERM_WRITE);
//			this._bf.clear(BitField.PERM_ADMIN);
//			this._bf.clear(BitField.PERM_ADMIN2);
//			this._bf.clear(BitField.PERM_ADMIN3);
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
		public function testBitField():void
		{
			Assert.assertEquals(this._bf.getValue(),_permission);
		}
		
		[Test]
		public function testClear():void
		{
			this._bf.clear(BitField.PERM_READ);
			Assert.assertEquals(this._bf.get(BitField.PERM_READ),false);
		}
		
		[Test]
		public function testGet():void
		{
//			this._bf.clear(BitField.PERM_READ);
			var getResult:Boolean = this._bf.get(BitField.PERM_READ);
			Assert.assertEquals(getResult,false);
		}
		
		[Test]
		public function testGetValue():void
		{
			var getValue:uint = this._bf.getValue();
			Assert.assertEquals(getValue,_permission);
		}
		
		[Test]
		public function testSet():void
		{
			var setValue:uint = BitField.PERM_ADMIN3;
			this._bf.set(setValue);
			var getSetValue:uint = this._bf.getValue();
			Assert.assertEquals(getSetValue,setValue);
		}
	}
}