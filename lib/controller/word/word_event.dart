part of 'word_bloc.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

class AddWord extends WordEvent {
  final String word;
  const AddWord(this.word);
}

class AddLetter extends WordEvent {
  final int index;
  const AddLetter(this.index);
}

class RemoveLetter extends WordEvent {
  final int index;
  const RemoveLetter(this.index);
}
