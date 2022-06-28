import 'package:flutter/material.dart';
import 'package:wordrush/controller/ticker/ticker.dart';
import 'package:wordrush/controller/ticker/ticker_bloc.dart';
import 'package:wordrush/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordrush/widgets/neomorphic_progress.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TickerBloc(const Ticker()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightBgColor,
        body: Center(
          child: BlocBuilder<TickerBloc, TickerState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // GreyText('${state.duration}'),
                  TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 1, end: state.duration / 60),
                      duration: const Duration(seconds: 1),
                      builder: (context, value, _) {
                        // return CircularProgressIndicator(
                        //   // value: state.duration / 60,
                        //   value: value,
                        // );
                        return NeomorphicProgress(value: value);
                      })
                ],
              );
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<TickerBloc>().add(TickerStarted());
              },
              child: const Icon(Icons.play_arrow),
            ),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<TickerBloc>().add(TickerExtended());
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<TickerBloc>().add(TickerStopped());
              },
              child: const Icon(Icons.stop),
            ),
          ],
        ));
  }
}
