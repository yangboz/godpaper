package ptolemy.geom3D.core
{
	internal class Logic
	{
		protected var _invalidated:Boolean;
		protected var _children:Array;

		public function Logic()
		{
			_invalidated = true;
		}

		public function invalidate():void
		{
			// flag _invalidated, which when calculate is called will cause doCalculation to be called before _invalidated is cleared
			_invalidated = true;

			// we're not invalidating children recursively then stop (also stop if this object has no children)
			if (_children == null) return;

			// invalidate all children recursively since cascade is true
			var str:String;
			var l:Logic;
			for (str in _children)
			{
				l = _children[str] as Logic;
				if (l == null) continue;
				l.invalidate();
			}
		}

		public function get isInvalidated():Boolean
		{
			return _invalidated;
		}

		public function calculate(t:Transformation, e:Eye):void
		{
			// recalculate this element if it has been invalidated
			if (_invalidated)
			{
				_invalidated = false;
				doCalculation(t, e);
			}

			// if there are no children of this object, there is nothing left to do
			if (_children == null) return;

			// now call calculate for each object in _children - note that unless
			// they are independently invalidated they will not
			var l:Logic;
			for each (l in _children)
			{
				l.calculate(t, e);
			}

			doPostChildrenCalculation();
		}

		protected function doCalculation(t:Transformation, e:Eye):void
		{
		}

		protected function doPostChildrenCalculation():void
		{
		}

		internal function addChild(l:Logic):Boolean
		{
			// if children is undefined, define it, add object and return true
			if (_children == null)
			{
				_children = [l];
				return true;
			}

			// try to find index of object in _children. If found, return false
			var i:int = _children.indexOf(l);
			if (i != -1) return false;

			// otherwise add object and return true
			_children.push(l);
			return true;
		}

		internal function removeChild(l:Logic):Boolean
		{
			// if _children is undefined, return false
			if (_children == null)
				return false;

			// try to find object in _children. If it's not found, return false
			var i:int = _children.indexOf(l);
			if (i == -1) return false;

			// remove object and return true
			_children.splice(i, 1);
			return true;
		}


	}
}