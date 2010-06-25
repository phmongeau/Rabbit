package
{

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/collidTiles.png")] private var CollideTiles:Class;
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

						
			_map = new OgmoTilemap(new Level1);
			_map.loadTilemap(_map.xml.tilesAbove[0], ImgTiles)
			
			_collideMap = new FlxTilemap();
			_collideMap.loadMap(new CollideMap1, CollideTiles, 16);
			_collideMap.drawIndex = 3;

			parseObjects(_map);

			add(_collideMap);
			add(_map);
		}

		override public function update():void
		{
			FlxU.collide(_player, _collideMap);
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
