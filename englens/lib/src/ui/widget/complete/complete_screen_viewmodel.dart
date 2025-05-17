import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CompleteScreenType { flashcard, wordReview }

class CompleteScreenArgs {
  final String title;
  final CompleteScreenType type;
  final FlashcardsScreenArgs flashcardArgs;

  CompleteScreenArgs({
    required this.title,
    required this.flashcardArgs,
    required this.type,
  });
}

class CompleteScreenViewmodel extends GetViewModelBase {
  late String title;
  late FlashcardsScreenArgs flashcardArgs;
  CompleteScreenType type = CompleteScreenType.flashcard;

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
    }

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
    }
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
}
