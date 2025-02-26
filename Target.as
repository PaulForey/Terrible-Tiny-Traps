package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Target extends Entity
	{
		public var frame: int = 0;
		public var id:int = 0;
		
		public function Target(_x: Number, _y: Number, _i:int)
		{
			x = _x;
			y = _y;
			id = _i;
			
			type = "target";
			
			var grid: Grid = new Grid(5, 5, 1, 1);
			
			mask = grid;
			
			for (var i: int = 0; i < 8; i++) {
				var _x: Number = (i < 2) ? i : 4 - i;
				var _y: Number = (i <= 4) ? i : 8 - i;
				
				if (i == 7) { _x = -1; }
				
				_x += 2;
				
				grid.setCell(_x, _y, true);
			}
		}
		
		public override function update (): void
		{
			frame = (frame + 1) % 8;
			
			var p: Player = collide("player", x, y) as Player;
			
			if (p)
			{
				if (! Main.realism) {
					Data.writeBool("gottarget"+id, true);
				}
				
				Level(FP.world).save(true, true);
				Logger.checkpoint(id, 13 - FP.world.classCount(Target));
				
				FP.world.remove(this);
				
				p.spawnX = p.x;
				p.spawnY = p.y;
				
				Audio.play("target");
			}
		}
		
		public override function render (): void
		{
			for (var i: int = 0; i < 8; i++) {
				if (i == frame) { continue; }
				
				var _x: Number = (i < 2) ? i : 4 - i;
				var _y: Number = (i <= 4) ? i : 8 - i;
				
				if (i == 7) { _x = -1; }
				
				_x += 2;
				
				FP.buffer.setPixel(x - FP.camera.x + _x, y - FP.camera.y + _y, Level.PLAYER);
			}
		}
	}
}
