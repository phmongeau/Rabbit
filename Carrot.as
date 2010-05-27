package
{
   import org.flixel.*;
   
   public class Carrot extends FlxSprite 
   {
      [Embed(source="data/carrot.png")] private var ImgCarrot:Class;

      public function Carrot(X:int, Y:int):void
      {
          super(X, Y);
          loadGraphic(ImgCarrot, true, false, 12, 30); //dont forget to change
      }
   }
}
