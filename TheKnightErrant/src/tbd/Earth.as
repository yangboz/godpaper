package 
tbd{
	import ptolemy.geom3D.platonic.Cube;
	
	public class Earth extends Jewel
	{
		protected override function update():void
		{
			var c:Cube = new Cube(size);
			solid(c,[0x66FF6666,0x33FF3366,0x33FF9966,0x99FF3366,0x99FF9966,0x66996666],0x99FF99,size);
		}
	}
}