import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'game.dart';

class Coin extends SpriteAnimationComponent with HasGameRef<MyGame> {
  static late SpriteAnimation spinAnimation;
  static late SpriteSheet sheet;
  static Vector2 v = Vector2(0, 100);
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  void update(double dt) {
    super.update(dt);
    position += v * dt;
    if (y - size[1] / 2 > gameRef.size[1]) {
      removeFromParent();
    }
  }

  void addNewCoin() {
    int temp = random(0, 6);

    gameRef.add(Coin()
      ..animation = spinAnimation
      ..position = Vector2(temp * 50 + size[0] / 2, 0 + size[1] / 2)
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center);
  }
}
