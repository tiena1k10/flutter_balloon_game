import 'package:balloon_game/game/coin.dart';
import 'package:balloon_game/game/game.dart';
import 'package:balloon_game/game/saw.dart';
import 'package:balloon_game/game/wheel_saw.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Figurehead extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  Figurehead() {
    this.add(RectangleHitbox());
  }
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Saw) {
      other.addNewSaw();
    } else if (other is Coin) {
      other.addNewCoin();
    } else if (other is WheelSaw) {
      print("va");
      other.addNewWheelSaw();
    }
  }
}

class Boom extends SpriteAnimationComponent {
  static late SpriteAnimation spinAnimation;
  static late SpriteSheet sheet;
}
