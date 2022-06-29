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
      List<String> quest, List<String> answer, String word, List<bool> clicked)
      : super(quest, answer, word, clicked);
}

class GameCompletedState extends WordState {
  GameCompletedState() : super([], [], '', []);
}

class IncorrectWordState extends WordState {
  const IncorrectWordState(
      List<String> quest, List<String> answer, String word, List<bool> clicked)
      : super(quest, answer, word, clicked);
}
