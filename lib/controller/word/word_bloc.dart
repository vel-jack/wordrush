import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(WordInitial()) {
    on<AddWord>(_onWordAdded);
    on<AddLetter>(_onLetterAdded);
    on<RemoveLetter>(_onLetterRemoved);
  }

  void _onWordAdded(AddWord event, Emitter<WordState> emit) {
    final quest = event.word.split('')..shuffle();

    emit(WordLoaded(quest, state.answer, event.word, state.clicked));
  }

  void _onLetterAdded(AddLetter event, Emitter<WordState> emit) {
    final answer = [...state.answer];
    answer[answer.indexOf('')] = state.quest[event.index];
    final clicked = [...state.clicked];
    clicked[event.index] = true;
    emit(WordLoaded(state.quest, answer, state.word, clicked));
  }

  void _onLetterRemoved(RemoveLetter event, Emitter<WordState> emit) {
    final answer = [...state.answer];
    final index = answer.lastIndexOf(state.quest[event.index]);
    for (int i = index; i < 4 - 1; i++) {
      answer[i] = answer[i + 1];
    }
    answer[3] = '';
    final clicked = [...state.clicked];
    clicked[event.index] = false;
    emit(WordLoaded(state.quest, answer, state.word, clicked));
  }
}
