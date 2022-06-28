part of 'ticker_bloc.dart';

abstract class TickerState extends Equatable {
  const TickerState(this.duration);
  final int duration;
  @override
  List<Object> get props => [duration];
}

class TickerInitial extends TickerState {
  const TickerInitial() : super(60);
}

class TickerRunning extends TickerState {
  const TickerRunning(int duration) : super(duration);
}

class TickerCompleted extends TickerState {
  const TickerCompleted() : super(0);
}
