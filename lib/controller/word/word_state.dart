part of 'word_bloc.dart';

abstract class WordState extends Equatable {
  const WordState(this.quest, this.answer, this.word, this.clicked);
  final List<String> quest;
  final List<String> answer;
  final List<bool> clicked;
  final String word;
  @override
  List<Object> get props => [quest, answer, word, clicked];
}

class WordInitialState extends WordState {
  WordInitialState(String word)
      : super(word.split('')..shuffle(), List.filled(4, ''), word,
            List.filled(4, false));
}

class WordLoadedState extends WordState {
  const WordLoadedState(
      super.quest, super.answer, super.word, super.clicked);
}

class GameCompletedState extends WordState {
  GameCompletedState() : super([], [], '', []);
}

class IncorrectWordState extends WordState {
  const IncorrectWordState(
      super.quest, super.answer, super.word, super.clicked);
}

class CorrectWordState extends WordState {
  const CorrectWordState(
      super.quest, super.answer, super.word, super.clicked);
}
