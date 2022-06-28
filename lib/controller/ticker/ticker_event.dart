part of 'ticker_bloc.dart';

abstract class TickerEvent extends Equatable {
  const TickerEvent();

  @override
  List<Object> get props => [];
}

class TickerStarted extends TickerEvent {}

class TickerExtended extends TickerEvent {}

class TickerTicked extends TickerEvent {
  const TickerTicked(this.duration);
  final int duration;
}

class TickerStopped extends TickerEvent {}
