part of 'word_bloc.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

class AddWordEvent extends WordEvent {
  final String word;
  const AddWordEvent(this.word);
}

class AddLetterEvent extends WordEvent {
  final int index;
  const AddLetterEvent(this.index);
}

class RemoveLetterEvent extends WordEvent {
  final int index;
  const RemoveLetterEvent(this.index);
}

class CheckWordEvent extends WordEvent {}
