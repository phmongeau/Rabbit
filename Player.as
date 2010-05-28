package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = 'data/rabitSS.png')] private var ImgPlayer:Class;
		
		private var moveSpeed:Number;

		public function Player(X:int, Y:int):void
		{
			super(X, Y);
			loadGraphic(ImgPlayer, false, true, 40, 67);
			
			moveSpeed =  200;
			drag.x = 200;
			maxVelocity.x = 700;
            velocity.y = 100;
			
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

