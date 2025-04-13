import 'package:englens/src/data/models/example.dart';
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
  static const String scheduleNotificationKey = 'scheduledNotification';
  static const String topicsKey = 'topics';

  Box<Word> get wordBox => Hive.box<Word>(wordKey);
  Box<ScheduleNotification> get scheduleNotificationBox =>
      Hive.box<ScheduleNotification>(scheduleNotificationKey);
  Box<Topic> get topicsBox => Hive.box<Topic>(topicsKey);

  init() async {
    final dir = await getApplicationCacheDirectory();
    await Hive.initFlutter(dir.path);

    Hive.registerAdapter(ExampleAdapter());
    Hive.registerAdapter(SenseAdapter());
    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(ScheduleNotificationAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(TopicAdapter());

    await Hive.openBox<Word>(wordKey);
    await Hive.openBox<ScheduleNotification>(scheduleNotificationKey);
    await Hive.openBox<Topic>(topicsKey);

    // await Hive.box(topicsKey).clear();
    // await topicsBox.clear();
  }
}
