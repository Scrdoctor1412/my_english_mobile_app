import 'package:englens/src/data/models/example.dart';

import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/leitner_box.dart';

import 'package:englens/src/data/models/schedule_notification.dart';
import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/data/models/lesson.dart';

import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppHive extends GetxController {
  static const String wordKey = 'word';
  static const String learningCategoryKey = 'learningCategory';
  static const String scheduleNotificationKey = 'scheduledNotification';
  static const String leitnerBoxKey = 'leitnerBox';

  Box<Word> get wordBox => Hive.box<Word>(wordKey);
  Box<LearningCategory> get learningCategoryBox =>
      Hive.box<LearningCategory>(learningCategoryKey);
  Box<ScheduleNotification> get scheduleNotificationBox =>
      Hive.box<ScheduleNotification>(scheduleNotificationKey);
  Box<LeitnerBox> get leitnerBoxBox => Hive.box<LeitnerBox>(leitnerBoxKey);

  init() async {
    final dir = await getApplicationCacheDirectory();
    await Hive.initFlutter(dir.path);

    Hive.registerAdapter(LearningCategoryAdapter());
    Hive.registerAdapter(LeitnerBoxAdapter());
    Hive.registerAdapter(LeitnerBoxTypeAdapter());
    Hive.registerAdapter(ExampleAdapter());
    Hive.registerAdapter(SenseAdapter());
    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(ScheduleNotificationAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(CategoryTypeAdapter());

    // await Hive.deleteBoxFromDisk(wordKey)

    await Hive.openBox<Word>(wordKey);
    await Hive.openBox<LearningCategory>(learningCategoryKey);
    await Hive.openBox<ScheduleNotification>(scheduleNotificationKey);
    await Hive.openBox<LeitnerBox>(leitnerBoxKey);

    // await Hive.deleteBoxFromDisk(wordKey)

    // await Hive.box(topicsKey).clear();
    // await Hive.box(levelBasedKey).clear();
    // await topicsBox.clear();
  }
}
