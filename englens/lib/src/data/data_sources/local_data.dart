import 'package:englens/src/configs/hive/app_hive.dart';

import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/leitner_box.dart';

import 'package:englens/src/data/models/schedule_notification.dart';

import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

abstract interface class LocalData extends GetxController {
  Future<void> saveWords(List<Word> words);

  List<Word> getWords();

  Future<void> saveWord(Word word);

  Future<void> saveScheduleNotification(
      ScheduleNotification scheduleNotification);

  Future<void> removeScheduleNotification(int id);

  List<ScheduleNotification> getScheduleNotifications();

  List<LearningCategory> getLearningCategory();

  Future<void> saveLearningCategories(List<LearningCategory> learningCategory);

  Future<void> updateLearningCategory(LearningCategory learningCategory);

  Future<void> saveLeitnerBoxes(List<LeitnerBox> leitnerBoxes);

  List<LeitnerBox> getLeitnerBoxes();

  Future<void> updateLeitnerBox(LeitnerBox leitnerBox);
}

class HiveDatabase extends GetxController implements LocalData {
  final AppHive _appHive;
  final uuid = Uuid();

  HiveDatabase({
    required AppHive appHive,
  }) : _appHive = appHive;

  @override
  List<ScheduleNotification> getScheduleNotifications() {
    return _appHive.scheduleNotificationBox.values.toList();
  }

  @override
  List<Word> getWords() {
    return _appHive.wordBox.values.toList();
  }

  @override
  Future<void> removeScheduleNotification(int id) {
    return _appHive.scheduleNotificationBox.delete(id);
  }

  @override
  Future<void> saveScheduleNotification(
      ScheduleNotification scheduleNotification) {
    return _appHive.scheduleNotificationBox
        .put(scheduleNotification.id, scheduleNotification);
  }

  @override
  Future<void> saveWord(Word word) {
    return _appHive.wordBox.put(word.id, word);
  }

  @override
  Future<void> saveWords(List<Word> words) async {
    await _appHive.wordBox.putAll(
      Map.fromEntries(
        words.map(
          (word) => MapEntry(word.id, word),
        ),
      ),
    );
  }

  @override
  List<LearningCategory> getLearningCategory() {
    return _appHive.learningCategoryBox.values.toList();
  }

  @override
  Future<void> saveLearningCategories(
      List<LearningCategory> learningCategory) async {
    await _appHive.learningCategoryBox.putAll(
      Map.fromEntries(
        learningCategory.map(
          (e) => MapEntry(e.id, e),
        ),
      ),
    );
  }

  @override
  Future<void> updateLearningCategory(LearningCategory learningCategory) async {
    await _appHive.learningCategoryBox
        .put(learningCategory.id, learningCategory);
  }

  @override
  List<LeitnerBox> getLeitnerBoxes() {
    return _appHive.leitnerBoxBox.values.toList();
  }

  @override
  Future<void> saveLeitnerBoxes(List<LeitnerBox> leitnerBoxes) async {
    await _appHive.leitnerBoxBox.putAll(
      Map.fromEntries(
        leitnerBoxes.map(
          (e) => MapEntry(e.index, e),
        ),
      ),
    );
  }

  @override
  Future<void> updateLeitnerBox(LeitnerBox leitnerBox) async {
    _appHive.leitnerBoxBox.put(leitnerBox.index, leitnerBox);
  }
}
