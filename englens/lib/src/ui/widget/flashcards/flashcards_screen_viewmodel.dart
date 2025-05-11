import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  late AnimationController animController;
  late Animation<double> animation;
  bool isFront = true;

  String idFlashCard = 'idflashcard';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      FlashcardsScreenArgs args = Get.arguments;
      title = args.title;
      wordList = args.wordList;
    }
    animController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animController.dispose();
    super.dispose();
  }

  void toggleCard() {
    if (isFront) {
      animController.forward();
    } else {
      animController.reverse();
    }
    isFront = !isFront;
    update();
  }

  void onTapCorrect() {
    pageIndex += 1;
		pageController.jumpToPage(pageIndex);
    // pageController.animateToPage(pageIndex,
    //     duration: const Duration(milliseconds: 600), curve: Curves.elasticIn);
		update();
  }

  void onTapIncorrect() {
		pageIndex += 1;
		pageController.jumpToPage(pageIndex);
    // pageIndex -= 1;
    // pageController.animateToPage(pageIndex,
    //     duration: const Duration(milliseconds: 600), curve: Curves.elasticIn);
		update();
	}
}
