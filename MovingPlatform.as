package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import flash.display.*;
	import flash.geom.*;
	
	public class MovingPlatform extends Entity
	{
		public var dx: int = 0;
		public var dy: int = 0;
		
		public function MovingPlatform(src: BitmapData, rect: Rectangle, _dx: int, _dy: int)
		{
			x = rect.x;
			y = rect.y;
			
			dx = _dx;
			dy = _dy;
			
			var bitmap: BitmapData = new BitmapData(rect.width, rect.height, true, 0x0);
			
			//var grid: Grid = new Grid(rect.width, rect.height, 1, 1);
			
			for (var ix: int = 0; ix < rect.width; ix++) {
				for (var iy: int = 0; iy < rect.height; iy++) {
					var pixel: uint = src.getPixel(x+ix, y+iy);
					
					if ((pixel & 0xFFFFFF) == Level.SPECIAL) {
						//grid.setCell(ix, iy, true);
						bitmap.setPixel32(ix, iy, Level.SOLID | 0xFF000000);
					}
				}
			}
			
			graphic = new Stamp(bitmap);
			mask = new Pixelmask(bitmap);
			
			type = "solid";
		}
		
		public override function update (): void
		{
			var e: Entity = collide("solid", x+dx, y+dy);
			
			if (e) {
				dx *= -1;
				dy *= -1;
			} else {
				var p: Player = collide("player", x, y -1) as Player;
				
				x += dx;
				y += dy;
				
				if (p && p.deathCount <= 0) {
					var e2: Entity = p.collide("solid", p.x+dx, p.y+dy);
					
					if (e2) {
						p.die();
					} else {
						p.x += dx;
						p.y += dy;
					}
				}
			}
		}
	}
}
