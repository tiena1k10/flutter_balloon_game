import 'dart:math';

import 'package:balloon_game/game/balloon.dart';
import 'package:balloon_game/game/figurehead.dart';
import 'package:balloon_game/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class WheelSaw extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  static Vector2 v = Vector2(0, 100);

  int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  WheelSaw() {
    add(RectangleHitbox());
  }
  void addNewWheelSaw() {
    int temp = random(0, 6);
    gameRef.add(WheelSaw()
      ..sprite = gameRef.wheelSawSprite
      ..position = Vector2(temp * 70, 0)
      ..size = Vector2(50, 50)
      ..anchor = Anchor.center);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += v * dt;
    if (y - size[1] / 2 > gameRef.size[1]) {
      removeFromParent();
    }
    // angle += 1 * dt - 1;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Balloon && other.visible) {
      other.visible = false;
      gameRef.changeScore(-10);
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
