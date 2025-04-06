import 'package:englens/src/data/models/example.dart';
import 'package:englens/src/data/models/schedule_notification.dart';
import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class AppHive extends GetxController {
  static const String wordKey = 'word';
  static const String scheduleNotificationKey = 'scheduledNotification';

  Box<Word> get wordBox => Hive.box<Word>(wordKey);
  Box<ScheduleNotification> get scheduleNotificationBox =>
      Hive.box<ScheduleNotification>(scheduleNotificationKey);

  init() async {
    final dir = await getApplicationCacheDirectory();
    await Hive.initFlutter(dir.path);

    Hive.registerAdapter(ExampleAdapter());
    Hive.registerAdapter(SenseAdapter());
    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(ScheduleNotificationAdapter());

    await Hive.openBox<Word>(wordKey);
    await Hive.openBox<ScheduleNotification>(scheduleNotificationKey);
  }
}
