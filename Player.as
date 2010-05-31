package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = 'data/rabitSS.png')] private var ImgPlayer:Class;
		
		private var moveSpeed:Number;
        public var jumpPower:int;

		public function Player(X:int, Y:int):void
		{
			super(X, Y);
			loadGraphic(ImgPlayer, false, true, 40, 67);
			
			moveSpeed =  100;
			drag.x = 200;
			maxVelocity.x = moveSpeed;
            acceleration.y = 350; //Gravity
            jumpPower = 250;
            maxVelocity.y = jumpPower * 10;
			
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
            if (FlxG.keys.justPressed("SPACE"))
            {
                velocity.y -= jumpPower;
            }

            if (velocity.x > 0)
                facing = 1;
            else if(velocity.x < 0)
                facing = 0;
			
			if (x < 0)
			{
				velocity.x *= -0.90;
				x = 0;
			}
			else if (x > 600)
			{
				velocity.x *= -0.90;
				x = 600;
			}
			super.update();
		}
	}
}

