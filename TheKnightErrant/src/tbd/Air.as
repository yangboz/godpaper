package 
tbd{
	import ptolemy.geom3D.platonic.Octahedron;
	
	public class Air extends Jewel
	{
		protected override function update():void
		{
			var o:Octahedron = new Octahedron(size);
			solid(o,[0xFFFF0066,0xFFFFCC66,0xCCFF9966,0xFFCC9966,0xFFFF0066,0xFFFFCC66,0xE0FC7D66,0xFFCC9966],0xFFFFCC,size);
		}
	}
}