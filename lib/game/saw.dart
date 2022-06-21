import 'dart:math';

import 'package:balloon_game/game/balloon.dart';
import 'package:balloon_game/game/figurehead.dart';
import 'package:balloon_game/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Saw extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  // 625/20 = 30;
  // 324/20 = 16;
  static Vector2 v = Vector2(0, 100);
  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  Saw() {
    add(RectangleHitbox());
    this.size = Vector2(30 * 4, 16);
  }
  void addNewSaw() {
    int temp = random(0, 6);

    gameRef.add(Saw()
      ..sprite = gameRef.sawSprite
      ..position = Vector2(temp * 70, 0)
      ..anchor = Anchor.center);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += v * dt;
    if (y - size[1] / 2 > gameRef.size[1]) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Balloon && other.visible) {
      gameRef.changeScore(-10);
      other.visible = false;
      Boom temp = Boom()
        ..position = intersectionPoints.first
        ..animation = Boom.spinAnimation
        ..anchor = Anchor.center
        ..size = Vector2(100, 100);
      gameRef.add(temp);
      Future.delayed(Duration(milliseconds: 700 - 10), () {
        temp.removeFromParent();
        other.visible = true;
      });
    }
  }
}
