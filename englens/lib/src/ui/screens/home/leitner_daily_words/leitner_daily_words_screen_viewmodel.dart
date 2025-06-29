import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/leitner_box.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/leitner_box_service.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_box/leitner_box_screen.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_box/leitner_box_screen_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LeitnerItem {
  String? title;
  String? abvTitle;
  Color? color;
  IconData? icon;
  Widget? stepperItem;
  LeitnerBoxType? leitnerBoxType;
  List<Word>? wordList;
  Function()? onTap;
  int? boxIndex;

  LeitnerItem({
    this.title,
    this.abvTitle,
    this.color,
    this.icon,
    this.stepperItem,
    this.leitnerBoxType,
    this.wordList,
    this.onTap,
    this.boxIndex,
  });

  LeitnerItem copyWith({
    String? title,
    String? abvTitle,
    Color? color,
    IconData? icon,
    Widget? stepperItem,
    LeitnerBoxType? leitnerBoxType,
    List<Word>? wordList,
    Function()? onTap,
    int? boxIndex,
  }) {
    return LeitnerItem(
      title: title ?? this.title,
      abvTitle: abvTitle ?? this.abvTitle,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      stepperItem: stepperItem ?? this.stepperItem,
      leitnerBoxType: leitnerBoxType ?? this.leitnerBoxType,
      wordList: wordList ?? this.wordList,
      onTap: onTap ?? this.onTap,
      boxIndex: boxIndex ?? this.boxIndex,
    );
  }
}

class LeitnerDailyWordsScreenViewModel extends GetViewModelBase {
  List<LeitnerItem> leitnerItems = [
    LeitnerItem(
      title: "Waiting list",
      abvTitle: "Pending",
      leitnerBoxType: LeitnerBoxType.pending,
      wordList: [],
      boxIndex: 0,
    ),
    LeitnerItem(
        title: "Every day",
        abvTitle: "A",
        color: ThemePrimary.primaryBlue,
        stepperItem: Text(
          "1",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leitnerBoxType: LeitnerBoxType.everyDay,
        wordList: [],
        boxIndex: 1),
    LeitnerItem(
      title: "Every 2 days",
      abvTitle: "B",
      color: ThemePrimary.primaryBlue,
      stepperItem: Text(
        "2",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      leitnerBoxType: LeitnerBoxType.every2days,
      wordList: [],
      boxIndex: 2,
    ),
    LeitnerItem(
        title: "Every 4 days",
        abvTitle: "C",
        color: ThemePrimary.primaryBlue,
        stepperItem: Text(
          "3",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leitnerBoxType: LeitnerBoxType.every4days,
        wordList: [],
        boxIndex: 3),
    LeitnerItem(
        title: "Every 8 days",
        abvTitle: "D",
        color: ThemePrimary.primaryBlue,
        stepperItem: Text(
          "4",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leitnerBoxType: LeitnerBoxType.every8days,
        wordList: [],
        boxIndex: 4),
    LeitnerItem(
      title: "Every 16 days",
      abvTitle: "E",
      color: ThemePrimary.primaryBlue,
      stepperItem: Text(
        "5",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      leitnerBoxType: LeitnerBoxType.every16days,
      wordList: [],
      boxIndex: 5,
    ),
    LeitnerItem(
      title: "Every 32 days",
      abvTitle: "F",
      color: ThemePrimary.primaryBlue,
      stepperItem: Text(
        "6",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      leitnerBoxType: LeitnerBoxType.every32days,
      wordList: [],
      boxIndex: 6,
    ),
    LeitnerItem(
      title: "Learned",
      abvTitle: "Learned",
      color: ThemePrimary.grey,
      icon: Icons.school_outlined,
      leitnerBoxType: LeitnerBoxType.learned,
      wordList: [],
      boxIndex: 7,
    ),
  ];

  List<LeitnerBox> leitnerBoxes = [];

  int countWaitingWords = 0;
  int countLearningWords = 0;
  int countLearnedWords = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initData();
  }

  void initData() async {
    leitnerBoxes = LeitnerBoxService.getLeitnerBoxes();

    //Gán list word
    for (var i = 0; i < leitnerBoxes.length; i++) {
      List<Word> wordList = [];
      //Lấy object Word từ id
      for (var wordId in leitnerBoxes[i].wordIds!) {
        var word = await LocalWordService.getWord(wordId);
        wordList.add(word);
      }
      //Gán vào props word list
      leitnerItems[i] = leitnerItems[i].copyWith(wordList: wordList);
    }
    //Gán onTap
    leitnerItems = leitnerItems
        .map((e) => e.copyWith(
              onTap: () => onTapToLeitnerBox(
                  e.abvTitle!, e.wordList!, e.leitnerBoxType!, e.boxIndex!),
            ))
        .toList();

    onCountLearnedWords();
    onCountLearningWords();
    onCountWaitingWords();

    update();
  }

  void onCountWaitingWords() {
    int count = 0;
    count = leitnerItems[0].wordList!.length;
    // return count;
    countWaitingWords = count;
    update();
  }

  void onCountLearningWords() {
    int count = 0;
    for (var i = 0; i < leitnerItems.length; i++) {
      if (i != 0 && i != 7) {
        count += leitnerItems[i].wordList!.length;
      }
    }

    countLearningWords = count;
    update();
  }

  void onCountLearnedWords() {
    int count = 0;
    count = leitnerItems[7].wordList!.length;
    countLearnedWords = count;
    update();
  }

  void onTapToLeitnerBox(String title, List<Word> wordList,
      LeitnerBoxType leitnerBoxType, int boxIndex) {
    Get.toNamed(
      LeitnerBoxScreen.routeName,
      arguments: LeitnerBoxScreenArgs(
        title: title,
        boxIndex: boxIndex,
        wordList: wordList,
        leitnerBoxType: leitnerBoxType,
      ),
    )!
        .then(
      (value) {
        initData();
      },
    );
  }
}
