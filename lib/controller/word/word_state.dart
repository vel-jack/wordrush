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

class WordInitial extends WordState {
  WordInitial()
      : super(['', '', '', ''], ['', '', '', ''], '',
            [false, false, false, false]);
}

class WordLoaded extends WordState {
  const WordLoaded(
      List<String> quest, List<String> answer, String word, List<bool> clicked)
      : super(quest, answer, word, clicked);
}
