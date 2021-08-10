part of 'dictionary_cubit.dart';

@immutable
abstract class DictionaryState {}

class DictionaryInitialState extends DictionaryState {}

class DictionarySearchingState extends DictionaryState {}

class DictionarySearchResultState extends DictionaryState {
  final List<WordCode> words;
  DictionarySearchResultState(this.words);
}

class DictionaryNoInternetState extends DictionaryState {}

class ErrorState extends DictionaryState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}
