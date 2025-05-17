import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/ui/widget/complete/complete_screen.dart';
import 'package:englens/src/ui/widget/complete/complete_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class FlashcardsScreenArgs {
  final String title;
  final List<Word> wordList;

  FlashcardsScreenArgs({
    required this.title,
    required this.wordList,
  });
}

class FlashcardsScreenViewmodel extends GetViewModelBase
    with GetSingleTickerProviderStateMixin {
  late String title;
  late List<Word> wordList;

  PageController pageController = PageController();
  int pageIndex = 0;

  //flash card is front or back
  bool isFront = true;

  String idFlashCard = 'idflashcard';
  late double progressValue;

  List<Word> listCorrect = [];
  List<Word> listIncorrect = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      FlashcardsScreenArgs args = Get.arguments;
      title = args.title;
      wordList = args.wordList;
    }

    progressValue = 1 / wordList.length;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void onUpdateProgressValue() {
    progressValue += 1 / wordList.length;
    update();
  }

  void onTapCorrect() {
    pageIndex += 1;
    if (pageIndex >= wordList.length) {
      Get.offNamed(
        CompleteScreen.routeName,
        arguments: CompleteScreenArgs(
            title: title,
            flashcardArgs:
                FlashcardsScreenArgs(title: title, wordList: wordList),
            type: CompleteScreenType.flashcard),
      );
      // Get.offNamed(CompleteScreen.routeName,
      //     arguments: CompleteScreenArgs(title: title, flashcard, wordList: wordList)));
      return;
    }
    ;
    listCorrect.add(wordList[pageIndex]);
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    onUpdateProgressValue();
    update();
  }

  void onTapIncorrect() {
    pageIndex += 1;
    if (pageIndex >= wordList.length) {
      Get.offNamed(
        CompleteScreen.routeName,
        arguments: CompleteScreenArgs(
            title: title,
            flashcardArgs: FlashcardsScreenArgs(
              title: title,
              wordList: wordList,
            ),
            type: CompleteScreenType.flashcard),
      );
      return;
    }
    ;
    listIncorrect.add(wordList[pageIndex]);
    onUpdateProgressValue();
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    update();
  }
}
