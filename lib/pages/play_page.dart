import 'package:balloon_game/game/game.dart';
import 'package:balloon_game/widgets/time.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  MyGame game = MyGame();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GameWidget(
          game: game,
          overlayBuilderMap: {
            'btn_back': (BuildContext context, MyGame game) {
              return game.buildBackButton();
            },
            "gameover": (BuildContext context, MyGame game) {
              return game.buildGameOver();
            },
            'timewidget': (BuildContext context, MyGame game) {
              return TimeWidget(
                gameRef: game,
              );
            },
          },
          initialActiveOverlays: ["btn_back", "timewidget"],
        ),
      ),
    );
  }
}
