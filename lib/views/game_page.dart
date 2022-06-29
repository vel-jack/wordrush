import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transition;
// package:get/get_navigation/src/routes/transitions_type.dart
import 'package:wordrush/controller/ticker/ticker.dart';
import 'package:wordrush/controller/ticker/ticker_bloc.dart';
import 'package:wordrush/controller/word/word_bloc.dart';
import 'package:wordrush/utils/constants.dart';
import 'package:wordrush/views/game_over.dart';
import 'package:wordrush/widgets/grey_icon.dart';

import 'package:wordrush/widgets/grey_text.dart';
import 'package:wordrush/widgets/neomorphic_button.dart';
import 'package:wordrush/widgets/neomorphic_progress.dart';

class GameRootWidget extends StatelessWidget {
  const GameRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TickerBloc>(
          create: (context) => TickerBloc(const Ticker())..add(StartTicker()),
        ),
        BlocProvider(
          create: (context) => WordBloc(
              ['BALL', 'DONE', 'GOLD', 'DART', 'NODE', 'TARD']..shuffle()),
        )
      ],
      child: const _GamePage(),
    );
  }
}

class _GamePage extends StatelessWidget {
  const _GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WordBloc, WordState>(
        listener: (context, state) {
          if (state is CorrectWordState) {
            context.read<TickerBloc>().add(ExtendTicker());
          } else if (state is WordLoadedState) {
            if (!state.answer.contains('')) {
              context.read<WordBloc>().add(CheckWordEvent());
            }
          }
        },
        builder: (context, state) {
          if (state is GameCompletedState) {
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
                      onTap: () => Get.back(),
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
                        size: 50,
                        onPressed: () {
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
                      children: const [
                        GreyText(
                          '10',
                          size: 30,
                        ),
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
                  '10',
                  size: 50,
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  BlocConsumer<TickerBloc, TickerState>(
                    listener: (context, state) {
                      if (state is TickerCompleted) {
                        // TODO need to pass scores
                        Get.off(() => const GameOverPage(),
                            transition: get_transition.Transition.cupertino);
                      }
                    },
                    builder: (context, state) {
                      return TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 1),
                          tween: Tween<double>(
                              begin: 1.0, end: state.duration / 60),
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
              Stack(
                children: [
                  NeomorphicButton(
                    size: 70,
                    child: const GreyIcon(Icons.fast_forward),
                    onPressed: () {
                      context.read<WordBloc>().add(const AddWordEvent('BALL'));
                    },
                  ),
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: NeomorphicButton(
                        size: 30,
                        child: GreyText(
                          '1',
                          size: 18,
                        ),
                      )),
                ],
              ),
              const Spacer()
            ],
          );
        },
      ),
    );
  }
}
