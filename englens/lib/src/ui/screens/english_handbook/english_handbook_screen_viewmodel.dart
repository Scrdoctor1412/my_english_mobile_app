import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

class EnglishHandbookScreenViewmodel extends GetViewModelBase
    with GetSingleTickerProviderStateMixin {
  int tabBarIndex = 0;
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final key = GlobalKey<ExpandableFabState>();
  late TabController tabController;

  // late WordList wordList;
  late List<Word> wordList;
  final _oxfordWordsRepo = Get.find<OxfordWordsRepositoryImpl>();

  @override
  onInit() {
    super.onInit();
    _onGetAllOxfordWords();
    tabController = TabController(length: 2, vsync: this);
  }

  _onGetAllOxfordWords() {
    var list = _oxfordWordsRepo.getAllOxfordWords();
    // test = list;
    list = list
        .where(
          (element) => element.pos.toLowerCase() != "none",
        )
        .toList();

    list.sort((a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));

    wordList = list;
  }

  String snakeCaseToNormal(String input) {
    return input
        .split('_') // Tách chuỗi bằng dấu gạch dưới
        .map(
          (word) => word[0].toUpperCase() + word.substring(1),
        ) // Viết hoa chữ cái đầu mỗi từ
        .join(' '); // Ghép lại các từ bằng dấu cách
  }

  void onTapToWordSearch() {
    Get.toNamed(WordSearchScreen.routeName,
        arguments: WordSearchScreenArgs(wordList: wordList));
  }

  // _calculateLessonsWords() {
  //   int count = 0;
  //   for (var topic in topicsList) {
  //     var lessons = topic.lessons;
  //     for (var lesson in lessons!) {
  //       var words = lesson.wordList;
  //       count += words!.length;
  //     }
  //   }
  //   print(count);
  // }

  void onTapChangeTabBarIndex(int value) {
    tabBarIndex = value;
    update();
  }

  Future<void> readJson() async {
    // final String res =
    //     await rootBundle.loadString('assets/json/oxford_words/a.json');

    // // print(res);
    // // final data = await json.decode(res);
    // // Word word = Word.fromJson(res);
    // // debugPrint(word.toString());
    // WordList data = WordList.fromJson(res);
    // print(data.words.toString());
  }
}
