import 'package:englens/src/configs/hive/app_hive.dart';
import 'package:englens/src/data/models/schedule_notification.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';

abstract interface class LocalData extends GetxController {
  Future<void> saveWords(List<Word> words);

  List<Word> getWords();

  Future<void> saveWord(Word word);

  Future<void> saveScheduleNotification(
      ScheduleNotification scheduleNotification);

  Future<void> removeScheduleNotification(int id);

  List<ScheduleNotification> getScheduleNotifications();
}

class HiveDatabase extends GetxController implements LocalData {
  final AppHive _appHive;

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
    return _appHive.wordBox.put(word.index, word);
  }

  @override
  Future<void> saveWords(List<Word> words) async {
    await _appHive.wordBox.putAll(
      Map.fromEntries(
        words.map(
          (word) => MapEntry(word.index, word),
        ),
      ),
    );
  }
}
