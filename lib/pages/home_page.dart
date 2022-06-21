import 'dart:ui';

import 'package:balloon_game/dodo_in_app_amazone/upgrade_page.dart';
import 'package:balloon_game/pages/play_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg2.png"), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //336 * 148
              SizedBox(
                width: 350,
                child: Lottie.asset("assets/images/balloon.json"),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => PlayPage());
                },
                child: SizedBox(
                  height: 148 / 2,
                  width: 336 / 2,
                  child: Image.asset("assets/images/play_button.png"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => UpgradePage());
                },
                child: SizedBox(
                  height: 148 / 2,
                  width: 336 / 2,
                  child: Image.asset("assets/images/setting_button.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
