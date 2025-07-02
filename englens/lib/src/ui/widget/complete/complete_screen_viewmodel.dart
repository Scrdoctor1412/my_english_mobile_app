import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/ui/widget/complete/difficult_words/difficult_words_screen.dart';
import 'package:englens/src/ui/widget/complete/difficult_words/difficult_words_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CompleteScreenType { flashcard, wordReview, leitnerBox }

class CompleteScreenArgs {
  final String title;
  final CompleteScreenType type;
  final FlashcardsScreenArgs flashcardArgs;
  final List<Word>? listIncorrect;

  CompleteScreenArgs({
    required this.title,
    required this.flashcardArgs,
    required this.type,
    this.listIncorrect,
  });
}

class CompleteScreenViewmodel extends GetViewModelBase {
  late String title;
  late FlashcardsScreenArgs flashcardArgs;
  CompleteScreenType type = CompleteScreenType.flashcard;
  List<Word> listIncorrect = [];
  Map<String, int> listMapWordIncorrect = {};
  List<String> listMapWordIncorrectKeys = [];

  String praiseTypeText = "";
  String reviewButtonTypeText = "";
  String flashcardButtonTypeText = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      CompleteScreenArgs args = Get.arguments;
      title = args.title;
      flashcardArgs = args.flashcardArgs;
      type = args.type;
      listIncorrect = args.listIncorrect ?? [];
    }

    initData();
  }

  void initData() {
    switch (type) {
      case CompleteScreenType.flashcard:
        praiseTypeText = "the flashcards";
        reviewButtonTypeText = "Review";
        flashcardButtonTypeText = "Reset Flashcard";
        break;
      case CompleteScreenType.wordReview:
        praiseTypeText = "word Review";
        reviewButtonTypeText = "Review";
        flashcardButtonTypeText = "Flashcard Practice";
        break;
      default:
        praiseTypeText = "the flashcards";
        reviewButtonTypeText = "Review";
        flashcardButtonTypeText = "Reset Flashcard";
        break;
    }

    for (var i = 0; i < listIncorrect.length; i++) {
      if (listMapWordIncorrect[listIncorrect[i].word] != null &&
          listMapWordIncorrect[listIncorrect[i].word] is int) {
        listMapWordIncorrect[listIncorrect[i].word] =
            listMapWordIncorrect[listIncorrect[i].word]! + 1;
      } else {
        listMapWordIncorrect[listIncorrect[i].word] = 1;
      }
    }

    listMapWordIncorrectKeys = listMapWordIncorrect.keys.toList();
  }

  void onTapToReview() {
    Get.offNamed(
      WordDetailsScreen.routeName,
      arguments: WordDetailsScreenViewmodelArgs(
        words: flashcardArgs.wordList,
        lessonTitle: flashcardArgs.title,
        isFromLessonDetailsScreen: true,
      ),
    );
  }

  void onTapResetFlashCards() {
    Get.offNamed(FlashcardsScreen.routeName, arguments: flashcardArgs);
  }

  void onTapToDifficultWords() {
    Get.toNamed(DifficultWordsScreen.routeName,
        arguments: DifficultWordsScreenArgs(listIncorrect: listIncorrect));
  }

  void onGetBack() {
    Get.back(result: "yes");
  }
}
