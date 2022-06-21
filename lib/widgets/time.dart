import 'dart:async';

import 'package:flutter/material.dart';
import 'package:balloon_game/game/game.dart';
import 'package:balloon_game/share_preferences.dart';

class TimeWidget extends StatefulWidget {
  static const String id = "Score";
  final MyGame gameRef;

  const TimeWidget({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  int? timeRemaining;

  late Timer timer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      int? seconds = await SPref.instance.getInt("seconds");

      if (seconds == null) {
        SPref.instance.setInt("seconds", 10);
        seconds = 10;
      }

      timeRemaining = seconds * 1000;

      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          timeRemaining = timeRemaining! - 10;
        });

        if (timeRemaining! <= 0) {
          print("Game Over");
          timer.cancel();
          widget.gameRef.endGame();
        }
      });
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      print("cancelling timer");
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.orange.withOpacity(0.7),
            ),
            child: Text(
              timeRemaining == null
                  ? "0.00"
                  : "${(timeRemaining! / 1000).toStringAsFixed(2)} ",
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
      ],
    );
  }
}
