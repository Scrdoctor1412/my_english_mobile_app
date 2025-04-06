import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

class EnglishHandbookScreenViewmodel extends GetViewModelBase {
  int tabBarIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final key = GlobalKey<ExpandableFabState>();
  late WordList wordList;
  final _oxfordWordsRepo = Get.find<OxfordWordsRepositoryImpl>();

  @override
  onInit() {
    _onGetAllOxfordWords();
    super.onInit();
  }

  _onGetAllOxfordWords() {
    var list = _oxfordWordsRepo.getAllOxfordWords();
    // test = list;
    wordList = WordList(words: list);
    print(wordList.words.length);
  }

  void onTapChangeTabBarIndex(int value) {
    tabBarIndex = value;
    update();
  }

  Future<void> readJson() async {
    final String res =
        await rootBundle.loadString('assets/json/oxford_words/a.json');

    // print(res);
    // final data = await json.decode(res);
    // Word word = Word.fromJson(res);
    // debugPrint(word.toString());
    WordList data = WordList.fromJson(res);
    print(data.words.toString());
  }
}
