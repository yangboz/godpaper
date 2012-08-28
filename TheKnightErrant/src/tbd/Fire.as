package 
tbd{
	import ptolemy.geom3D.platonic.Tetrahedron;
	
	public class Fire extends Jewel
	{
		
		protected override function update():void
		{
			var t:Tetrahedron = new Tetrahedron(size);
			solid(t,[0xFF000F66,0xFFc60066,0xffcc0066,0xff77aa66],0xFF000F,size);
		}
		
	}
}