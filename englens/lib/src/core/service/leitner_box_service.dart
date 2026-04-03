import 'package:englens/src/data/models/leitner_box.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/leitner_box_repository.dart';
import 'package:englens/src/core/service/local_notification_service.dart';
import 'package:englens/src/core/service/local_word_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeitnerBoxService {
  static final LeitnerBoxRepositoryImpl _leitnerBoxRepositoryImpl =
      Get.find<LeitnerBoxRepositoryImpl>();

  static List<LeitnerBox> leitnerBoxes = [];

  static final Map<LeitnerBoxType, int> boxIntervals = {
    LeitnerBoxType.everyDay: 1,
    LeitnerBoxType.every2days: 2,
    LeitnerBoxType.every4days: 4,
    LeitnerBoxType.every8days: 8,
    LeitnerBoxType.every16days: 16,
    LeitnerBoxType.every32days: 32,
  };

  LeitnerBoxService._();

  static Future<void> initData() async {
    await _leitnerBoxRepositoryImpl.initData();
    leitnerBoxes = _leitnerBoxRepositoryImpl.getLeitnerBoxes();
    await saveLeitnerBoxes(leitnerBoxes);

    //check today words to notify users to learn
    var todayWords = await getTodaysWords();
    if (todayWords.isNotEmpty) {
      LocalNotificationService.showSimpleNotification(
        id: 1,
        title: "Daily Words",
        body: "You have ${todayWords.length} words to learn today",
      );
    }
  }

  static Future<void> saveLeitnerBoxes(List<LeitnerBox> leitnerBoxes) async {
    await _leitnerBoxRepositoryImpl.saveLeitnerBoxes(leitnerBoxes);
  }

  static void updateLeitnerBox(LeitnerBox leitnerBox) async {
    await _leitnerBoxRepositoryImpl.updateLeitnerBox(leitnerBox);
  }

  static List<LeitnerBox> getLeitnerBoxes() {
    return _leitnerBoxRepositoryImpl.getLeitnerBoxes();
  }

  static Future<List<Word>> getTodaysWords() async {
    List<Word> todayWords = [];
    for (var box in leitnerBoxes) {
      for (var wordId in box.wordIds!) {
        var word = await LocalWordService.getWord(wordId);
        int interval = boxIntervals[box.boxType] ?? 0;
        var now = DateTime.now();
        if (word.lastLearned != null && word.lastLearned != "") {
          DateTime wordLastLearned = DateTime.parse(word.lastLearned!);
          var difference = now.difference(wordLastLearned);
          if (difference.inDays >= interval) {
            todayWords.add(word);
          }
        }
      }
    }
    return todayWords;
  }

  static void addNewToLeitnerBox(String wordId) {
    if (leitnerBoxes.isNotEmpty) {
      leitnerBoxes[0] = leitnerBoxes[0].copyWith(
        wordIds: [...leitnerBoxes[0].wordIds!, wordId],
      );
      saveLeitnerBoxes(leitnerBoxes);
    } else {
      debugPrint("leitnerBox service: leitnerBox is empty");
    }
  }
}
