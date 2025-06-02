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

  String idFlashCard = 'idflashcard';
  late double progressValue;

  List<Word> tempWordList = [];
  List<Word> listCorrect = [];
  List<Word> listIncorrect = [];
  List<Word> tempListIncorrect = [];

  bool isVolumeOn = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      FlashcardsScreenArgs args = Get.arguments;
      title = args.title;
      wordList = args.wordList;
    }
    tempWordList = wordList.map((e) => e).toList();
    progressValue = 1 / wordList.length;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void toggleVolume() {
    isVolumeOn = !isVolumeOn;
    update();
  }

  void onUpdateProgressValue() {
    progressValue += 1 / tempWordList.length;
    update();
  }

  void onTapCorrect() {
    //Kiểm tra nếu từ trong flashcard hiện tại trùng với từ trong list incorrect thì remove từ đó ra khỏi list incorrect
    if (listIncorrect.firstWhereOrNull(
            (element) => element.word == tempWordList[pageIndex].word) !=
        null) {
      tempListIncorrect.removeWhere(
        (element) => element.word == tempWordList[pageIndex].word,
      );
    }

    pageIndex += 1;

    //if end of the flashcards move to completion screen
    if (pageIndex >= wordList.length && tempListIncorrect.isEmpty) {
      Get.offNamed(
        CompleteScreen.routeName,
        arguments: CompleteScreenArgs(
          title: title,
          flashcardArgs: FlashcardsScreenArgs(title: title, wordList: wordList),
          type: CompleteScreenType.flashcard,
          listIncorrect: listIncorrect,
        ),
      );

      return;
    }

    //thêm từ vào list correct
    if (listCorrect.indexWhere(
            (element) => element.word == tempWordList[pageIndex].word) !=
        -1) {
      listCorrect.add(tempWordList[pageIndex]);
    }

    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    onUpdateProgressValue();
    update();
  }

  void onTapIncorrect() {
    listIncorrect.add(tempWordList[pageIndex]);
    tempListIncorrect.add(tempWordList[pageIndex]);

    tempWordList = [...wordList, ...listIncorrect];

    pageIndex += 1;

    onUpdateProgressValue();
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

    update();
  }
}
