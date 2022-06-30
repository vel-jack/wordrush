import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:wordrush/controller/audio_controller.dart';
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20).copyWith(top: 30),
            child: Obx(() => GreyText(
                  'Best : ${userController.score}',
                  size: 20,
                )),
          ),
          const GreyText(
            'WORD',
            size: 50,
          ),
          const GreyText(
            'RUSH',
            size: 30,
          ),
          const Spacer(),
          NeomorphicButton(
            size: 150,
            onPressed: () {
              AudioController().tap.resume();
              Get.to(
                () => const GameRootWidget(),
                transition: Transition.upToDown,
              );
            },
            radius: 100,
            child: const GreyIcon(Icons.play_arrow, size: 100),
          ),
          const Spacer(),
          Obx(() {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GreyText(
                    userController.isAuthLoading
                        ? 'WAIT....'
                        : userController.user == null
                            ? 'SIGN IN'
                            : 'SIGN OUT',
                    size: 18,
                    isDown: true,
                  ),
                ),
                NeomorphicButton(
                  size: 60,
                  child: userController.isAuthLoading
                      ? CircularProgressIndicator(
                          color: kDarkShadowColor,
                        )
                      : const GreyIcon(
                          Icons.sports_esports,
                          size: 36,
                        ),
                  onPressed: () async {
                    AudioController().tap.resume();
                    if (userController.user == null) {
                      await userController.signIn();
                    } else {
                      await userController.signOut();
                    }
                  },
                )
              ],
            );
          }),
          const Spacer()
        ],
      ),
    );
  }
}
