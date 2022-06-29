import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wordrush/views/game_page.dart';
import 'package:wordrush/widgets/grey_icon.dart';
import 'package:wordrush/widgets/grey_text.dart';
import 'package:wordrush/widgets/neomorphic_button.dart';

// TODO must test on device
class GameOverPage extends StatelessWidget {
  const GameOverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GreyText(
              'Time is up',
              size: 48,
            ),
            const GreyText(
              '1000',
              size: 100,
            ),
            const GreyText('Best : 124290'),
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
