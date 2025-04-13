import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
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

  final _topicsRepo = Get.find<TopicsRepositoryImpl>();
  late List<Topic> topicsList;

  @override
  onInit() {
    super.onInit();
    _onGetAllOxfordWords();
    _onGetAllTopics();
    tabController = TabController(length: 2, vsync: this);
  }

  _onGetAllOxfordWords() {
    var list = _oxfordWordsRepo.getAllOxfordWords();
    // test = list;
    wordList = list;
    print(wordList.length);
  }

  _onGetAllTopics() {
    var list = _topicsRepo.getAllTopics();
    topicsList = list;
    print(topicsList.length);
    // _calculateLessonsWords();
  }

  String snakeCaseToNormal(String input) {
    return input
        .split('_') // Tách chuỗi bằng dấu gạch dưới
        .map((word) =>
            word[0].toUpperCase() +
            word.substring(1)) // Viết hoa chữ cái đầu mỗi từ
        .join(' '); // Ghép lại các từ bằng dấu cách
  }

  int countLessonWords(int index) {
    var lessons = topicsList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
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
