package ptolemy.geom3D
{
	public class Platonic
	{
		public static function get CUBE():Platonic { return _cube; }
		public static function get TETRAHEDRON():Platonic { return _tetrahedron; }
		public static function get OCTAHEDRON():Platonic { return _octahedron; }
		public static function get DODECAHEDRON():Platonic { return _dodecahedron; }
		public static function get ICOSAHEDRON():Platonic { return _icosahedron; }
		
		private static var _cube:Platonic = new Platonic("cube");
		private static var _tetrahedron:Platonic = new Platonic("tetrahedron");
		private static var _octahedron:Platonic = new Platonic("octahedron");
		private static var _dodecahedron:Platonic = new Platonic("dodecahedron");
		private static var _icosahedron:Platonic = new Platonic("icosahedron");
		
		private var _name:String;
		
		public function Platonic(name:String) { _name = name; }
		
		public function toString():String { return _name; }
		
	}
}