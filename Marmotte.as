package
{
   import org.flixel.*;
   
   public class Marmotte extends FlxSprite 
   {
      [Embed(source="data/marmotte.png")] private var ImgMarmotte:Class;

      public function Marmotte(X:int, Y:int):void
      {
          super(X, Y);
          loadGraphic(ImgMarmotte, true, false, 32, 23); 
      }
   }
}
