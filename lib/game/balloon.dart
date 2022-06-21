import 'package:balloon_game/game/coin.dart';
import 'package:balloon_game/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';

class Balloon extends SpriteComponent
    with Draggable, CollisionCallbacks, HasGameRef<MyGame> {
  bool visible = true;
  Vector2? dragDeltaPosition;
  bool get isDragging => dragDeltaPosition != null;
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
  }

  bool onDragStart(DragStartInfo startPosition) {
    dragDeltaPosition = startPosition.eventPosition.game - position;
    return false;
  }

  @override
  bool onDragUpdate(DragUpdateInfo event) {
    if (isDragging) {
      final localCoords = event.eventPosition.game;
      position = localCoords - dragDeltaPosition!;
      if (y < gameRef.size[1] * 2 / 3) y = gameRef.size[1] * 2 / 3;
      if (y > gameRef.size[1] - size[1] / 2) y = gameRef.size[1] - size[1] / 2;
      if (x > gameRef.size[0] - size[0] / 2) x = gameRef.size[0] - size[0] / 2;
      if (x < size[0] / 2) x = size[0] / 2;
    }
    return false;
  }

  @override
  bool onDragEnd(DragEndInfo event) {
    dragDeltaPosition = null;
    return false;
  }

  @override
  bool onDragCancel() {
    dragDeltaPosition = null;
    return false;
  }

  @override
  void render(Canvas canvas) {
    if (visible) {
      super.render(canvas);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Coin && visible) {
      other.removeFromParent();
      gameRef.changeScore(10);
    }
  }
}
