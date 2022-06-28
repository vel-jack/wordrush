import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wordrush/utils/constants.dart';
import 'package:wordrush/views/game_page.dart';
import 'package:wordrush/widgets/grey_icon.dart';
import 'package:wordrush/widgets/grey_text.dart';
import 'package:wordrush/widgets/neomorphic_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBgColor,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20).copyWith(top: 30),
            child: const GreyText(
              'Best : 23',
              size: 20,
            ),
          ),
          const GreyText(
            'WORD',
            size: 50,
          ),
          const GreyText(
            'RUSH',
            size: 30,
          ),
          const SizedBox(height: 100),
          NeomorphicButton(
            size: 150,
            onPressed: () {
              Get.to(
                () => const GameRootWidget(),
                transition: Transition.upToDown,
              );
            },
            radius: 100,
            child: const GreyIcon(Icons.play_arrow, size: 100),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              NeomorphicButton(
                child: const GreyIcon(Icons.leaderboard, size: 36),
                onPressed: () {
                  showMessage(context, 'In progress...', kDarkShadowColor);
                },
              ),
              NeomorphicButton(
                child: const GreyIcon(
                  Icons.sports_esports,
                  size: 36,
                ),
                onPressed: () {
                  showMessage(context, 'In progress...', kDarkShadowColor);
                },
              ),
              const SizedBox()
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }

  void showMessage(BuildContext context, String hello, Color color,
      {int seconds = 1}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        hello.toUpperCase(),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
      elevation: 10,
      duration: Duration(seconds: seconds),
    ));
  }
}
