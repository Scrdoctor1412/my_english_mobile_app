import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/models/example.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:englens/src/data/models/schedule_notification.dart';
import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppHive extends GetxController {
  static const String wordKey = 'word';
  static const String learningCategoryKey = 'learningCategory';
  static const String scheduleNotificationKey = 'scheduledNotification';
  static const String topicsKey = 'topics';
  static const String levelBasedKey = 'levelBased';
  static const String idiomsKey = 'idioms';
  static const String collocationsKey = 'collocations';
  static const String engProverbsKey = 'engProverbs';
  static const String phrasalVerbsKey = 'phrasalVerbs';

  Box<Word> get wordBox => Hive.box<Word>(wordKey);
  Box<LearningCategory> get learningCategoryBox =>
      Hive.box<LearningCategory>(learningCategoryKey);
  Box<ScheduleNotification> get scheduleNotificationBox =>
      Hive.box<ScheduleNotification>(scheduleNotificationKey);
  Box<Topic> get topicsBox => Hive.box<Topic>(topicsKey);
  Box<LevelBased> get levelBaseBox => Hive.box<LevelBased>(levelBasedKey);
  Box<Idioms> get idiomsBox => Hive.box<Idioms>(idiomsKey);
  Box<Collocations> get collocationsBox =>
      Hive.box<Collocations>(collocationsKey);
  Box<EngProverbs> get engProverbsBox => Hive.box<EngProverbs>(engProverbsKey);
  Box<PhrasalVerbs> get phrasalVerbs => Hive.box<PhrasalVerbs>(phrasalVerbsKey);

  init() async {
    final dir = await getApplicationCacheDirectory();
    await Hive.initFlutter(dir.path);

    Hive.registerAdapter(LearningCategoryAdapter());
    Hive.registerAdapter(ExampleAdapter());
    Hive.registerAdapter(SenseAdapter());
    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(ScheduleNotificationAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(TopicAdapter());
    Hive.registerAdapter(LevelBasedAdapter());
    Hive.registerAdapter(IdiomsAdapter());
    Hive.registerAdapter(CollocationsAdapter());
    Hive.registerAdapter(EngProverbsAdapter());
    Hive.registerAdapter(PhrasalVerbsAdapter());
    Hive.registerAdapter(CategoryTypeAdapter());

    // await Hive.deleteBoxFromDisk(wordKey)

    await Hive.openBox<Word>(wordKey);
    await Hive.openBox<LearningCategory>(learningCategoryKey);
    await Hive.openBox<ScheduleNotification>(scheduleNotificationKey);
    await Hive.openBox<Topic>(topicsKey);
    await Hive.openBox<LevelBased>(levelBasedKey);
    await Hive.openBox<Idioms>(idiomsKey);
    await Hive.openBox<Collocations>(collocationsKey);
    await Hive.openBox<EngProverbs>(engProverbsKey);
    await Hive.openBox<PhrasalVerbs>(phrasalVerbsKey);

    // await Hive.deleteBoxFromDisk(wordKey)

    // await Hive.box(topicsKey).clear();
    // await Hive.box(levelBasedKey).clear();
    // await topicsBox.clear();
  }
}
