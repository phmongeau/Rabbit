package
{
    import org.flixel.*;

    public class Light extends FlxSprite
    {
		[Embed(source="data/glow-light.png")] private var ImgGlow:Class;
        
        private var darkness:FlxSprite;

        public function Light(X:Number, Y:Number, darkness:FlxSprite):void
        {
            super(X,Y);

            //createGraphic(100,100, 0xffffffff);
            loadGraphic(ImgGlow);

            this.darkness = darkness;
            this.blend = "screen";
        }

        override public function render():void
        {
            var screenXY:FlxPoint = getScreenXY();

            darkness.draw(this, screenXY.x - this.width/2, screenXY.y - this.height/2);
            super.render();
        }

        override public function update():void
        {
            super.update();
        }
    }
}
