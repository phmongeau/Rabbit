package
{

	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/collidTiles.png")] private var CollideTiles:Class;
		[Embed(source = 'data/map01.tmx', mimeType = "application/octet-stream")] private var EmbeddedTmx:Class;		
		[Embed(source = 'data/levels/Level2.oel', mimeType = "application/octet-stream")] private var Level1:Class;
		[Embed(source = 'data/levels/CollideMap1.txt', mimeType = "application/octet-stream")] private var CollideMap1:Class;

		//private var _level:Ogmo;
		private var _collideMap:FlxTilemap;
		private var _map:FlxTilemap;
		public var _veggies:FlxGroup;
		public var _marmottes:FlxGroup;
		public var _player:FlxSprite;

        private var darkness:FlxSprite;
        //private var light:Light;
		
		override public function create():void
		{
            darkness = new FlxSprite();
            darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
            darkness.scrollFactor = new FlxPoint(0,0);
            darkness.blend = "multiply";

			FlxG.mouse.hide();
			FlxG.bgColor = 0xFF88AACC;

			_veggies = new FlxGroup();
			_marmottes = new FlxGroup();

			//load the ogmo level file
			var level:OgmoLevel = new OgmoLevel(new Level1);

			//load the main map
			_map = level.loadTilemap("tilesAbove", ImgTiles);

			//load the collide map
			_collideMap = level.loadGrid("floors", CollideTiles);

			parseObjects(level);


			//add(_collideMap);
			add(_map);
            add(darkness);
		}

		override public function draw():void
		{
			darkness.fill(0xff333333);
			super.draw();
		}

		override public function update():void
		{
			FlxG.collide(_player, _collideMap);
			//FlxG.collide(_player, _map);
			FlxG.overlap(_veggies, _player, gotCarrot);
			FlxG.overlap(_marmottes, _player, marmotteHitPlayer);
			super.update();
		}

		private function parseObjects(map:OgmoLevel):void
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
                add(new Light(i.@x, i.@y, darkness));
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
