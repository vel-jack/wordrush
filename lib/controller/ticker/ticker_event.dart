part of 'ticker_bloc.dart';

abstract class TickerEvent extends Equatable {
  const TickerEvent();

  @override
  List<Object> get props => [];
}

class StartTicker extends TickerEvent {}

class ExtendTicker extends TickerEvent {}

class TickTicker extends TickerEvent {
  const TickTicker(this.duration);
  final int duration;
}

class StopTicker extends TickerEvent {}
