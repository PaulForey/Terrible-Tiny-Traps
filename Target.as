package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Target extends Entity
	{
		public var frame: int = 0;
		
		public function Target(_x: Number, _y: Number)
		{
			x = _x;
			y = _y;
			
			type = "target";
			
			setHitbox(5, 5, 0, 0);
			
			//var grid = mask = new Grid(5, 5, 1, 1);
			
			
		}
		
		public override function update (): void
		{
			frame = (frame + 1) % 8;
		}
		
		public override function render (): void
		{
			for (var i: int = 0; i < 8; i++) {
				if (i == frame) { continue; }
				
				var _x: Number = (i < 2) ? i : 4 - i;
				var _y: Number = (i <= 4) ? i : 8 - i;
				
				if (i == 7) { _x = -1; }
				
				_x += 2;
				
				FP.buffer.setPixel(x - FP.camera.x + _x, y - FP.camera.y + _y, 0xFF000000);
			}
		}
	}
}
