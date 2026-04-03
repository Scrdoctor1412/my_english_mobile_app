// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/core/service/local_word_service.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordSearchScreenArgs {
  final List<Word> wordList;
  WordSearchScreenArgs({required this.wordList});
}

class WordSearchScreenViewmodel extends GetViewModelBase {
  late List<Word> wordList;
  List<Word> searchResult = [];
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      WordSearchScreenArgs args = Get.arguments as WordSearchScreenArgs;
      wordList = args.wordList;
    } else {
      initData();
    }
  }

  void initData() async {
    wordList = await LocalWordService.getAllWordsFromLocal();
    update();
  }

  void onSearch(String value) {
    searchResult = wordList
        .where((word) => word.word.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  void onTapToWordDetails(int index) {
    Get.toNamed(
      WordDetailsScreen.routeName,
      arguments: WordDetailsScreenViewmodelArgs(
        isFromLessonDetailsScreen: false,
        onlyWord: [searchResult[index]],
      ),
    );
  }
}
