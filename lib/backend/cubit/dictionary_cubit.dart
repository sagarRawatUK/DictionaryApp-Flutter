import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dictionaryapp/backend/cubit/connnectivity_cubit.dart';
import 'package:dictionaryapp/backend/repo/word_repo.dart';
import 'package:dictionaryapp/models/word_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  ConnnectivityCubit? connectivityCubit;
  StreamSubscription? internetStreamSubscription;
  final WordRepo wordRepo;

  DictionaryCubit(this.wordRepo, this.connectivityCubit)
      : super(DictionaryInitialState()) {
    internetStreamSubscription = connectivityCubit?.stream.listen((state) {
      if (state is ConnnectivityDisconnected) {
        emit(DictionaryNoInternetState());
      } else {
        emit(DictionaryInitialState());
      }
    });
  }

  final queryController = TextEditingController();

  Future getWordSearched() async {
    emit(DictionarySearchingState());

    try {
      final List<WordCode> words =
          await wordRepo.getWords(queryController.text);
      if (words == null) {
        emit(ErrorState("There is some Error"));
      } else {
        print(words.toString());
        emit(DictionarySearchResultState(words));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}
