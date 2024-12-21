import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transition;
import 'package:wordrush/controller/audio_controller.dart';
import 'package:wordrush/controller/ticker/ticker.dart';
import 'package:wordrush/controller/ticker/ticker_bloc.dart';
import 'package:wordrush/controller/word/word_bloc.dart';
import 'package:wordrush/utils/constants.dart';
import 'package:wordrush/utils/words.dart';
import 'package:wordrush/views/game_over.dart';
import 'package:wordrush/widgets/grey_icon.dart';

import 'package:wordrush/widgets/grey_text.dart';
import 'package:wordrush/widgets/neomorphic_button.dart';
import 'package:wordrush/widgets/neomorphic_progress.dart';

class GameRootWidget extends StatelessWidget {
  const GameRootWidget({super.key, this.word});
  final String? word;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TickerBloc>(
          create: (context) => TickerBloc(const Ticker())..add(StartTicker()),
        ),
        BlocProvider(
          create: (context) => WordBloc(word == null
              ? [...words..shuffle()]
              : [word!, ...words..shuffle()]),
        )
      ],
      child: const _GamePage(),
    );
  }
}

class _GamePage extends StatelessWidget {
  const _GamePage();

  @override
  Widget build(BuildContext context) {
    Rx<int> score = 0.obs;
    return Scaffold(
      body: BlocConsumer<WordBloc, WordState>(
        listener: (context, state) {
          if (state is CorrectWordState) {
            AudioController().correct.resume();
            score.value += 1;
            context.read<TickerBloc>().add(ExtendTicker());
          } else if (state is WordLoadedState) {
            if (!state.answer.contains('')) {
              context.read<WordBloc>().add(CheckWordEvent());
            }
          }
          if (state is IncorrectWordState) {
            AudioController().error.resume();
          }
        },
        builder: (context, state) {
          if (state is GameCompletedState) {
            AudioController().done.resume();
            context.read<TickerBloc>().add(StopTicker());
            if (score.value > userController.score) {
              userController.setScore(score.value);
            }
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: GreyText(
                          "Hey I'm looking for the words to describe you"),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        AudioController().tap.resume();
                        Get.back();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 1.0, end: 0.0),
                              duration: const Duration(seconds: 2),
                              curve: Curves.slowMiddle,
                              builder: (context, value, widget) {
                                return NeomorphicProgress(value: value);
                              }),
                          GreyIcon(
                            Icons.done_rounded,
                            size: 100,
                            color: kDarkShadowColor,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const GreyText(
                      'COMPLETED 🎮',
                      isDown: true,
                    )
                  ]),
            );
          }
          return Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(left: 16),
                    child: NeomorphicButton(
                        size: 60,
                        onPressed: () {
                          AudioController().tap.resume();
                          Get.back();
                        },
                        child: const GreyIcon(
                          Icons.home,
                          size: 30,
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 100),
                            transitionBuilder: (child, anim) {
                              return ScaleTransition(scale: anim, child: child);
                            },
                            child: GreyText(
                              key: Key(score.value.toString()),
                              score.value.toString(),
                              size: 30,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (state is IncorrectWordState)
                TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween<double>(begin: 10.0, end: 0.0),
                    curve: Curves.bounceOut,
                    builder: (context, value, widget) {
                      return Transform.translate(
                        offset: Offset(value, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              4,
                              (i) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NeomorphicButton(
                                      size: 60,
                                      radius: 10,
                                      isClicked: state.answer[i].isEmpty,
                                      child: GreyText(state.answer[i]),
                                    ),
                                  )).toList(),
                        ),
                      );
                    })
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      4,
                      (i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NeomorphicButton(
                              size: 60,
                              radius: 10,
                              isClicked: state.answer[i].isEmpty,
                              child: GreyText(state.answer[i]),
                            ),
                          )).toList(),
                ),
              Container(
                height: 80,
                margin: const EdgeInsets.all(10),
                child: const GreyText(
                  '', // ? Greet message in future
                  size: 50,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  BlocConsumer<TickerBloc, TickerState>(
                    listener: (context, state) {
                      if (state is TickerRunning) {
                        if (state.duration < 6) {
                          AudioController().tick.resume();
                        }
                      }
                      if (state is TickerCompleted) {
                        AudioController().done.resume();
                        int best = userController.score;
                        if (score.value > best) {
                          userController.setScore(score.value);
                          best = score.value;
                        }
                        Get.off(
                            () => GameOverPage(
                                  score: score.value,
                                  bestScore: best,
                                  word: context.read<WordBloc>().state.word,
                                ),
                            transition: get_transition.Transition.cupertino);
                      }
                    },
                    builder: (context, state) {
                      return TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 1),
                          tween: Tween<double>(
                              begin: 1.0, end: state.duration / 30),
                          builder: (context, value, widget) {
                            return NeomorphicProgress(
                              size: 300,
                              value: value,
                            );
                          });
                    },
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    margin: const EdgeInsets.all(20),
                    child: GridView.count(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        padding: const EdgeInsets.all(12),
                        crossAxisCount: 2,
                        children: List.generate(
                            4,
                            (i) => NeomorphicButton(
                                  radius: 20,
                                  isClicked: state.clicked[i],
                                  onPressed: () {
                                    AudioController().tap.resume();
                                    state.clicked[i]
                                        ? context
                                            .read<WordBloc>()
                                            .add(RemoveLetterEvent(i))
                                        : context
                                            .read<WordBloc>()
                                            .add(AddLetterEvent(i));
                                  },
                                  child: GreyText(
                                    state.quest[i],
                                    isDown: state.clicked[i],
                                  ),
                                )).toList()),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: GreyText(
                  'SKIP',
                  size: 18,
                  isDown: true,
                ),
              ),
              NeomorphicButton(
                size: 70,
                child: const GreyIcon(
                  Icons.fast_forward,
                  size: 34,
                ),
                onPressed: () {
                  AudioController().tap.resume();
                  context.read<WordBloc>().add(SkipWordEvent());
                },
              ),
              const Spacer()
            ],
          );
        },
      ),
    );
  }
}
