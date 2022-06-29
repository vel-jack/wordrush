import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final List<String> _words;

  WordBloc(List<String> words)
      : _words = words,
        super(WordInitialState(words.first)) {
    on<AddLetterEvent>(_onLetterAdded);
    on<RemoveLetterEvent>(_onLetterRemoved);
    on<CheckWordEvent>(_onCheckWord);
    on<SkipWordEvent>(_onSkipWordEvent);
  }

  void _onLetterAdded(AddLetterEvent event, Emitter<WordState> emit) {
    final answer = [...state.answer];
    answer[answer.indexOf('')] = state.quest[event.index];
    final clicked = [...state.clicked];
    clicked[event.index] = true;
    emit(WordLoadedState(state.quest, answer, state.word, clicked));
  }

  void _onLetterRemoved(RemoveLetterEvent event, Emitter<WordState> emit) {
    final answer = [...state.answer];
    final index = answer.lastIndexOf(state.quest[event.index]);
    for (int i = index; i < 4 - 1; i++) {
      answer[i] = answer[i + 1];
    }
    answer[3] = '';
    final clicked = [...state.clicked];
    clicked[event.index] = false;
    emit(WordLoadedState(state.quest, answer, state.word, clicked));
  }

  void _onCheckWord(CheckWordEvent event, Emitter<WordState> emit) async {
    final answer = state.answer.join();
    if (_words.contains(answer)) {
      if (state is WordLoadedState) {
        _words.remove(answer);
        if (_words.isNotEmpty) {
          emit(CorrectWordState(
              state.quest, state.answer, state.word, state.clicked));
          await Future.delayed(const Duration(milliseconds: 200), () {
            emit(WordInitialState(_words.first));
          });
        } else {
          emit(GameCompletedState());
        }
      }
    } else {
      emit(IncorrectWordState(
          state.quest, List.filled(4, ''), state.word, List.filled(4, false)));
    }
  }

  void _onSkipWordEvent(SkipWordEvent event, Emitter<WordState> emit) {
    _words.shuffle();
    // log(_words.toString());
    emit(WordInitialState(_words.first));
  }
}
