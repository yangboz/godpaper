package ptolemy.geom3D.core
{
	public class Transformation
	{
		private var _matrix:Array;

		public function Transformation()
		{
			_matrix = [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
		}

		public function transform(pt:Array):Array
		{
			var i:int;
			var j:int;
			var arr:Array;

			arr = [0, 0, 0, 0];
			for (j = 0;j < 4;j++)
			{
				for (i = 0;i < 4;i++)
				{
					arr[j] += _matrix[i][j] * pt[i];
				}
			}
			return arr;
		}

		public function clone():Transformation
		{
			var t:Transformation;

			t = new Transformation();
			t._matrix = _matrix.concat();
			return t;
		}

		public static function combine(a:Transformation, b:Transformation):Transformation
		{
			var i:int;
			var j:int;
			var k:int;
			var t:Transformation;

			t = new Transformation();

			for (i = 0;i < 4;i++)
			{
				for (j = 0;j < 4;j++)
				{
					t._matrix[i][j] = 0;
					for (k = 0;k < 4;k++)
					{
						t._matrix[i][j] += a._matrix[k][j] * b._matrix[i][k];
					}
				}
			}

			return t;
		}

		public static function euler(A:Number, B:Number, G:Number):Transformation
		{
			var t:Transformation = new Transformation();

			var sinA:Number = Math.sin(A);
			var sinB:Number = Math.sin(B);
			var sinG:Number = Math.sin(G);
			var cosA:Number = Math.cos(A);
			var cosB:Number = Math.cos(B);
			var cosG:Number = Math.cos(G);

			t._matrix[0] = [cosA * cosG - cosB * sinA * sinG, -cosB * cosG * cosA - cosA * sinG, sinA * sinB, 0];
			t._matrix[1] = [cosG * sinA + cosA * cosB * sinG, cosA * cosB * cosG - sinA * sinG, -cosA * sinB, 0];
			t._matrix[2] = [sinB * sinG, cosG * sinB, cosB, 0];

			return t;
		}

		public static function about(v:SpatialVector, angle:Number):Transformation
		{
			var t:Transformation = new Transformation();

			var sinA:Number = Math.sin(angle);
			var cosA:Number = Math.cos(angle);

			var dn:Number = 1 / v.magnitude;
			var x:Number = v.i * dn;
			var y:Number = v.j * dn;
			var z:Number = v.k * dn;

			t._matrix[0] = [cosA + (1 - cosA) * x * x, (1 - cosA) * x * y - sinA * z, (1 - cosA) * x * z + sinA * y, 0];
			t._matrix[1] = [(1 - cosA) * x * y + sinA * z, cosA + (1 - cosA) * y * y, (1 - cosA) * y * z - sinA * x, 0];
			t._matrix[2] = [(1 - cosA) * z * x - sinA * y, (1 - cosA) * z * y + sinA * x, cosA + (1 - cosA) * z * z, 0];

			return t;
		}

		public static function translate(x:Number, y:Number, z:Number):Transformation
		{
			var t:Transformation = new Transformation();
			t._matrix[3][0] = x;
			t._matrix[3][1] = y;
			t._matrix[3][2] = z;
			return t;
		}

		public function toString():String
		{
			var i:int;
			var j:int;
			var arr:Array;
			var str:String;

			arr = new Array();

			for (i = 0;i < 4;i++)
			{
				for (j = 0;j < 4;j++)
				{
					if (arr[j] == null) arr[j] = new Array();
					str = _matrix[i][j].toString().substr(0, 4);
					while (str.length < 5) str += " ";
					arr[j][i] = str;
				}
			}

			for (i = 0;i < 4;i++)
			{
				arr[i] = "| " + arr[i].join(" | ") + " |";
			}
			return arr.join("\n");
		}
	}
}