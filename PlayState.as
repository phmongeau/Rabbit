package
{
	import net.pixelpracht.tmx.*;

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source = 'data/map01.tmx', mimeType = "application/octet-stream")] private var EmbeddedTmx:Class;		
		[Embed(source = 'data/levels/Level1.oel', mimeType = "application/octet-stream")] private var Level1:Class;
		[Embed(source = 'data/levels/CollideMap1.txt', mimeType = "application/octet-stream")] private var CollideMap1:Class;

		private var _map:OgmoTilemap;
		private var _collideMap:FlxTilemap;
		public var _veggies:FlxGroup;
		public var _marmottes:FlxGroup;
		public var _player:FlxSprite;
		
		override public function create():void
		{
			FlxG.mouse.hide();
			FlxState.bgColor = 0xFF88AACC;

			_veggies = new FlxGroup();
			_marmottes = new FlxGroup();

			//var tmx:TmxMap = new TmxMap(new XML( new EmbeddedTmx));
			//var mapCsv:String = toCSV(tmx, "map");
			//_map = new FlxTilemap();
			//_map.loadMap(mapCsv, ImgTiles);
						
			_map = new OgmoTilemap();
			_map.loadOgmo(new Level1, ImgTiles)
			
//			var mapCsv:String = _map.xml.floors.text()
//			FlxG.log(mapCsv);
			_collideMap = new FlxTilemap();
			_collideMap.loadMap(new CollideMap1, ImgTiles, 16);

			parseObjects(_map);

			add(_collideMap);
			add(_map);
		}

		override public function update():void
		{
			FlxU.collide(_player, _map);
			FlxU.overlap(_veggies, _player, gotCarrot);
			FlxU.overlap(_marmottes, _player, marmotteHitPlayer);
			super.update();
		}

		private function parseObjects(map:OgmoTilemap):void
		{
			var objects:XML = map.xml.actors[0];
			var i:XML;
			
			for each(i in objects.rabbit)
			{
				_player = new Player(i.@x, i.@y);
				add(_player);
			}
			
			for each(i in objects.carrot)
			{
				add(_veggies.add(new Carrot(i.@x, i.@y)));
			}
		}

		private function spawnObject(obj:TmxObject):void
		{
			//Add game objects based on the type property
			switch(obj.type)
			{
				case "Player":
					_player = new Player(obj.x, obj.y);
					add(_player);
					return;
				case "Carrot":
					add(_veggies.add(new Carrot(obj.x, obj.y)));
					return;

				case "marmotte":
					add(_marmottes.add(new Marmotte(obj.x, obj.y)));
					return;
			}
		}

		private function gotCarrot(c:Carrot, p:Player):void
		{
			c.kill();
			FlxG.score += 1;
			FlxG.log(FlxG.score.toString());
		}

		private function marmotteHitPlayer(m:Marmotte, p:Player):void
		{
			FlxG.log('overlap');
			p.health -= 1;
			p.hit();
		}

	}
}
