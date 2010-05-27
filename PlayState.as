package
{
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
//    import net.pixelpracht.tmx.TmxMap;
//    import net.pixelpracht.tmx.TmxObject;
//    import net.pixelpracht.tmx.TmxObjectGroup;
    import net.pixelpracht.tmx.*;

    import org.flixel.*;

    public class PlayState extends FlxState
    {
        [Embed(source="data/tiles.png")] private var ImgTiles:Class;
        [Embed(source = 'data/map01.tmx', mimeType = "application/octet-stream")] private var EmbeddedTmx:Class;

        private var _map:FlxTilemap;
        
        override public function create():void
        {
            FlxG.mouse.hide();
            FlxState.bgColor = 0xFF88AACC;

            var tmx:TmxMap = new TmxMap(new XML( new EmbeddedTmx));
            var mapCsv:String = toCSV(tmx);

            _map = new FlxTilemap();
            _map.loadMap(mapCsv, ImgTiles);

            
            parseObjects(tmx);

            add(_map);
        }

        private function toCSV(tmx:TmxMap):String
        {
            var mapCsv:String = tmx.getLayer('map').toCsv(tmx.getTileSet('tiles'));
            return mapCsv;
        }

        private function parseObjects(tmx:TmxMap):void
        {
            var group:TmxObjectGroup = tmx.getObjectGroup('objects');
            for each(var object:TmxObject in group.objects)
                spawnObject(object);
        }

        private function spawnObject(obj:TmxObject):void
        {
            //Add game objects based on the type property
            switch(obj.type)
            {
                case "Player":
                    add(new Player(obj.x, obj.y));
                    return;
                case "Carrot":
                    add(new Carrot(obj.x, obj.y));
                    return;
            }
        }

    }
}
