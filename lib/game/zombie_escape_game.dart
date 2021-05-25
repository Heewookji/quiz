import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

class ZombieEscapeGame extends BaseGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await images.load('character_zombie_sheet.png');
    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('character_zombie_sheet.png'),
      columns: 9,
      rows: 5,
    );
    SpriteComponent player = SpriteComponent(
      sprite: spriteSheet.getSprite(3, 8),
      position: viewport.canvasSize / 2,
      size: Vector2(100, 150),
    );
    player.anchor = Anchor.center;
    add(player);
  }
}
