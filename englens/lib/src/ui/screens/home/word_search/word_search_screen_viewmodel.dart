// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordSearchScreenArgs {
  final List<Word> wordList;
  WordSearchScreenArgs({
    required this.wordList,
  });
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
    }
  }

  void onSearch(String value) {
    searchResult = wordList
        .where((word) => word.word.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }
}
