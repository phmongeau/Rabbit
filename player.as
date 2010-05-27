package
{
	import org.flixel.*;
	
	public class PlayerShip extends FlxSprite
	{
		[Embed(source = 'data/rabitS.png')] private var ImgPlayer:Class;
		
		private var moveSpeed:Number;
		public function PlayerShip(X:int, Y:int):void
		{
			super(X, Y);
			loadGraphic(ImgPlayer, false, true, 16, 16);
			
			moveSpeed =  200;
			drag.x = 200;
			maxVelocity.x = 700;
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.LEFT)
			{
				velocity.x -= moveSpeed * FlxG.elapsed * 3;
			}
			
			if (FlxG.keys.RIGHT)
			{
				velocity.x += moveSpeed * FlxG.elapsed * 3;
			}
			
			if (x < 0)
			{
				velocity.x *= -0.90;
				x = 0;
			}
			else if (x > 234)
			{
				velocity.x *= -0.90;
				x = 234;
			}
			super.update();
		}
	}
}

