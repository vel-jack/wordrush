import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wordrush/controller/ticker/ticker.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  TickerBloc(Ticker ticker)
      : _ticker = ticker,
        super(const TickerInitial()) {
    on<StartTicker>(_onStarted);
    on<ExtendTicker>(_onExtended);
    on<TickTicker>(_onTicked);
    on<StopTicker>(_onStopped);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(StartTicker event, Emitter<TickerState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(60).listen((tick) {
      add(TickTicker(tick));
    });
  }

  void _onTicked(TickTicker event, Emitter<TickerState> emit) {
    emit(state.duration > 0
        ? TickerRunning(event.duration)
        : const TickerCompleted());
  }

  void _onExtended(ExtendTicker event, Emitter<TickerState> emit) {
    var extentedTime = state.duration + 10;
    if (state.duration + 10 > 60) {
      extentedTime = 60;
    }
    if (state is TickerRunning) {
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(extentedTime).listen((tick) {
        add(TickTicker(tick));
      });
    }
  }

  void _onStopped(StopTicker event, Emitter<TickerState> emit) {
    if (state is TickerRunning) {
      _tickerSubscription?.cancel();
      emit(const TickerInitial());
    }
  }
}
