import 'package:balloon_game/game/balloon.dart';
import 'package:balloon_game/game/coin.dart';
import 'package:balloon_game/game/figurehead.dart';
import 'package:balloon_game/game/saw.dart';
import 'package:balloon_game/game/wheel_saw.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGame extends FlameGame with HasDraggables, HasCollisionDetection {
  Balloon balloon = Balloon();
  late Timer coundownTimer;
  late Sprite balloonSprite;
  Saw saw = Saw();
  MyGame() {
    coundownTimer = Timer(10, onTick: () {
      Saw.v.y += 3;
      Coin.v.y += 3;
      WheelSaw.v.y += 3;
    }, repeat: true);
  }

  int score = 0;
  late TextComponent textScore;

  late Sprite sawSprite;
  late Sprite wheelSawSprite;
  Vector2 balloonSize = Vector2(308 / 6, 464 / 6);
  @override
  Future<void>? onLoad() async {
    // debugMode = true;
    super.onLoad();
    // load background image
    Sprite sptBg = await loadSprite("bg.png");
    SpriteComponent background = SpriteComponent()
      ..sprite = sptBg
      ..size = Vector2(size[0], size[1]);
    add(background);
    // load balloon image
    // 308 x 464
    balloonSprite = await loadSprite("balloon.png");
    balloon
      ..sprite = balloonSprite
      ..position = Vector2(size[0] / 2, size[1] - balloonSize[1])
      ..anchor = Anchor.center
      ..size = balloonSize;
    add(balloon);
    // add saw 30x16
    sawSprite = await loadSprite("saw_medium.png");

    saw
      ..sprite = sawSprite
      ..position = Vector2(size[0] / 2, 0)
      ..anchor = Anchor.center;

    add(saw);
    // add wheelsaw
    wheelSawSprite = await loadSprite("blade_3.png");
    WheelSaw wheelSaw = WheelSaw()
      ..position = Vector2(size[0] / 4, 0 - balloonSize[1])
      ..anchor = Anchor.center
      ..sprite = wheelSawSprite
      ..size = Vector2(50, 50);
    add(wheelSaw);
    // add figurehead
    Figurehead figurehead = Figurehead()
      ..position = Vector2(0, balloonSize[1] * 2 + 50)
      ..size = Vector2(99999, 2);
    add(figurehead);

    // load coin sheet & animation
    Coin.sheet = SpriteSheet(
        image: await images.load("coin_sheet.png"), srcSize: Vector2(151, 151));
    Coin.spinAnimation =
        Coin.sheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 6);
    Coin a = Coin()
      ..anchor = Anchor.center
      ..position = Vector2(size[0] / 2, 0 - balloonSize[1] - 25)
      ..animation = Coin.spinAnimation
      ..size = Vector2(50, 50);
    add(a);
    //load boom sheet & animation
    Boom.sheet = SpriteSheet(
        image: await images.load("boom_sheet.png"), srcSize: Vector2(499, 499));
    Boom.spinAnimation =
        Boom.sheet.createAnimation(row: 0, stepTime: 0.1, from: 0, to: 7);
    // add scoreText
    textScore = TextComponent(
        text: '🎈 : 0',
        textRenderer:
            TextPaint(style: TextStyle(fontSize: 20, color: Colors.red)))
      ..x = size[0] - 100
      ..y = 10;
    add(textScore);
  }

  @override
  void update(double dt) {
    super.update(dt);
    coundownTimer.update(dt);
  }

  void changeScore(int nScore) {
    if (nScore < 0 && score == 0) {
      return;
    }
    this.score += nScore;
    textScore.text = '🎈 : $score';
  }

  void endGame() {
    this.pauseEngineFn!();
    // add overlay
    overlays.add("gameover");
  }
  // build overlays

  Widget buildBackButton() {
    return Positioned(
      top: 10,
      left: 20,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: 40,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Image.asset("assets/images/home_button.png"),
        ),
      ),
    );
  }

  // game over
  Widget buildGameOver() {
    return Positioned(
      child: Center(
        child: Container(
          height: 300,
          width: 300,
          child: SizedBox(
            child: Scaffold(
              backgroundColor: Colors.pink.withOpacity(0.6),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.asset("assets/images/icon.png"),
                  ),
                  Center(
                    child: Text(
                      "Game over",
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Home")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
