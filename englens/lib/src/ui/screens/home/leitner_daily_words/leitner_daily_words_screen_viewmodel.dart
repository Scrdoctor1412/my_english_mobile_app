import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_record.dart';
import 'package:englens/src/data/models/leitner_box.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/learning_record_service.dart';
import 'package:englens/src/service/leitner_box_service.dart';
import 'package:englens/src/service/local_notification_service.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_box/leitner_box_screen.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_box/leitner_box_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/settings/settings_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/complete/complete_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  List<Word> todayWords = [];

  int countWaitingWords = 0;
  int countLearningWords = 0;
  int countLearnedWords = 0;

  final Map<LeitnerBoxType, int> boxIntervals = {
    LeitnerBoxType.everyDay: 1,
    LeitnerBoxType.every2days: 2,
    LeitnerBoxType.every4days: 4,
    LeitnerBoxType.every8days: 8,
    LeitnerBoxType.every16days: 16,
    LeitnerBoxType.every32days: 32,
  };

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

    onGetTodayWords();

    update();
  }

  void onGetTodayWords() async {
    todayWords = [];
    for (var box in leitnerBoxes) {
      if (box.boxType == LeitnerBoxType.pending) {
        // var word = await LocalWordService.getWord(wordId);
        // todayWords.add(word);
        var words = List.generate(
            box.wordIds!.length,
            (index) async =>
                await LocalWordService.getWord(box.wordIds![index]));
        todayWords = [...todayWords, ...await Future.wait(words)];
        continue;
      }
      for (var wordId in box.wordIds!) {
        var word = await LocalWordService.getWord(wordId);

        int interval = boxIntervals[box.boxType] ?? 0;
        var now = DateTime.now();
        if (word.lastLearned != null && word.lastLearned != "") {
          DateTime wordLastLearned = DateTime.parse(word.lastLearned!);
          var difference = now.difference(wordLastLearned);
          if (difference.inDays >= interval) {
            int indexDuplicate =
                todayWords.indexWhere((element) => element.id == word.id);
            if (indexDuplicate == -1) {
              // todayWords.removeAt(indexDuplicate);
              todayWords.add(word);
            }
          }
        }
      }
    }

    //cập nhật số lượng từ trong pending box
    leitnerItems[0] = leitnerItems[0].copyWith(wordList: todayWords);
    // leitnerBoxes[0].wordIds = todayWords.map((e) => e.id!).toList();
    // update();
  }

  bool shouldLearnToday(LeitnerBox box) {
    if (box.boxType == LeitnerBoxType.pending || box.lastLearned == null) {
      return true;
    }

    final interval = boxIntervals[box.boxType];
    if (interval == null) return false;

    // final nextDate = box.lastLearned!.add(Duration(days: interval).toString());
    final today = DateTime.now();

    // return !nextDate.isAfter(today); // hôm nay hoặc quá hạn
    return true;
  }

  void onTapSettings() {
    // LocalNotificationService.showSimpleNotification(
    //     id: 1, title: "test", body: "test body");
    Get.offAllNamed(
      TabsScreen.routeName,
      arguments: TabsScreenViewArgs(tabIndex: 3),
    );
  }

  void onTapLearnNow() async {
    // List<Word> todayWords = [];

    // for (var i = 0; i < leitnerBoxes.length; i++) {
    //   // bỏ pending & learned
    //   final box = leitnerBoxes[i];
    //   if (shouldLearnToday(box)) {
    //     for (var wordId in box.wordIds!) {
    //       final word = await LocalWordService.getWord(wordId);
    //       todayWords.add(word);
    //     }
    //   }
    // }

    if (todayWords.isEmpty) {
      // Get.snackbar("Thông báo", "Không có từ nào cần học hôm nay");
      Get.snackbar(
        "Notification",
        "No words to learn today",
        backgroundColor: Colors.grey.shade300,
      );
      return;
    }

    var res = await Get.toNamed(
      FlashcardsScreen.routeName,
      arguments: FlashcardsScreenArgs(
          title: "Today words",
          wordList: todayWords,
          completeScreenType: CompleteScreenType.leitnerBox),
    );
    print("res: $res");
    if (res is bool && res) {
      //Lưu vào box theo dõi từ vựng qua các ngày
      var learningRecords = LearningRecordService.getLearningRecords();
      String now = DateFormat("dd/MM/yyyy").format(DateTime.now());
      for (var record in learningRecords) {
        if (record.id == now) {
          // record.wordIds = [];
          record.wordIds = [
            ...record.wordIds ?? [],
            ...todayWords
                .map(
                  (e) => e.id!,
                )
                .toList()
          ];
        }
      }

      //Xử lý chuyển đổi các từ qua lại các box
      for (var box in leitnerBoxes) {
        //Duyệt qua từng box

        if (box.wordIds != null && box.wordIds!.isNotEmpty) {
          var tempWordIdsList = box.wordIds!
              .map(
                (e) => e,
              )
              .toList();
          for (var wordId in box.wordIds!) {
            //Duyệt qua từng từ có trong box - nếu từ trong box trùng với từ hôm nay thì sẽ remove từ đó ra khỏi box và truyền nó cho box kế tiếp
            if (todayWords.indexWhere((element) => element.id == wordId) !=
                -1) {
              if (box.boxType == LeitnerBoxType.pending) {
                leitnerBoxes[box.index! + 2].wordIds!.add(wordId);
              } else if (box.index! + 1 < leitnerBoxes.length) {
                leitnerBoxes[box.index! + 1].wordIds!.add(wordId);
              } else {
                leitnerBoxes[1].wordIds!.add(wordId);
              }

              todayWords.removeWhere((element) => element.id == wordId);
              tempWordIdsList.removeWhere((element) => element == wordId);
            }
          }
          box.wordIds = tempWordIdsList;
        }
      }

      await LearningRecordService.saveRecords(learningRecords);
      await LeitnerBoxService.saveLeitnerBoxes(leitnerBoxes);
      initData();
    }
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
