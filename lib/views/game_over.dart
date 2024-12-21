import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wordrush/controller/audio_controller.dart';
import 'package:wordrush/views/game_page.dart';
import 'package:wordrush/widgets/grey_icon.dart';
import 'package:wordrush/widgets/grey_text.dart';
import 'package:wordrush/widgets/neomorphic_button.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage(
      {super.key,
      required this.score,
      required this.bestScore,
      required this.word});
  final int score;
  final int bestScore;
  final String word;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GreyText(
              'Time is up',
              size: 40,
            ),
            GreyText(
              '$score',
              size: 100,
            ),
            GreyText('Best : $bestScore'),
            const Divider(),
            const GreyText(
              'Answer',
              isDown: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GreyText(
                "'$word'",
                size: 48,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                NeomorphicButton(
                  child: const GreyIcon(Icons.home, size: 36),
                  onPressed: () {
                    AudioController().tap.resume();
                    Get.back();
                    // showMessage(context, 'In progress...', kDarkShadowColor);
                  },
                ),
                NeomorphicButton(
                  child: const GreyIcon(
                    Icons.refresh,
                    size: 36,
                  ),
                  onPressed: () {
                    AudioController().tap.resume();
                    Get.off(() => const GameRootWidget(),
                        transition: Transition.upToDown);
                  },
                ),
                const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
