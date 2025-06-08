import 'package:englens/src/configs/hive/app_hive.dart';
import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:englens/src/data/models/schedule_notification.dart';
import 'package:englens/src/data/models/topic.dart';
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

  List<Topic> getTopics();

  Future<void> saveTopics(List<Topic> topics);

  List<LevelBased> getLevelBased();

  Future<void> saveLevelBased(List<LevelBased> levelBased);

  List<Idioms> getIdioms();

  Future<void> saveIdioms(List<Idioms> idioms);

  List<Collocations> getCollocations();

  Future<void> saveCollocations(List<Collocations> collocations);

  List<EngProverbs> getEngProverbs();

  Future<void> saveEngProverbs(List<EngProverbs> engProverbs);

  List<PhrasalVerbs> getPhrasalVerbs();

  Future<void> savePhrasalVerbs(List<PhrasalVerbs> phrasalVerbs);
}

class HiveDatabase extends GetxController implements LocalData {
  final AppHive _appHive;
  final uuid = Uuid();

  HiveDatabase({
    required AppHive appHive,
  }) : _appHive = appHive;

  @override
  List<Topic> getTopics() {
    return _appHive.topicsBox.values.toList();
  }

  @override
  Future<void> saveTopics(List<Topic> topics) async {
    // TODO: implement saveTopics
    // throw UnimplementedError();
    await _appHive.topicsBox.putAll(
      Map.fromEntries(
        topics.map(
          (topic) => MapEntry(topic.title, topic),
        ),
      ),
    );
  }

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

  @override
  List<LevelBased> getLevelBased() {
    // TODO: implement getLevelBased
    return _appHive.levelBaseBox.values.toList();
  }

  @override
  Future<void> saveLevelBased(List<LevelBased> levelBased) async {
    // TODO: implement saveLevelBased
    await _appHive.levelBaseBox.putAll(Map.fromEntries(
      levelBased.map(
        (levelBased) => MapEntry(levelBased.title, levelBased),
      ),
    ));
  }

  @override
  List<Collocations> getCollocations() {
    return _appHive.collocationsBox.values.toList();
  }

  @override
  List<EngProverbs> getEngProverbs() {
    return _appHive.engProverbsBox.values.toList();
  }

  @override
  List<Idioms> getIdioms() {
    return _appHive.idiomsBox.values.toList();
  }

  @override
  List<PhrasalVerbs> getPhrasalVerbs() {
    return _appHive.phrasalVerbs.values.toList();
  }

  @override
  Future<void> saveCollocations(List<Collocations> collocations) async {
    await _appHive.collocationsBox.putAll(Map.fromEntries(
      collocations.map(
        (collocations) => MapEntry(collocations.title, collocations),
      ),
    ));
  }

  @override
  Future<void> saveEngProverbs(List<EngProverbs> engProverbs) async {
    await _appHive.engProverbsBox.putAll(Map.fromEntries(
      engProverbs.map(
        (engProverbs) => MapEntry(engProverbs.title, engProverbs),
      ),
    ));
  }

  @override
  Future<void> saveIdioms(List<Idioms> idioms) async {
    await _appHive.idiomsBox.putAll(Map.fromEntries(
      idioms.map(
        (idioms) => MapEntry(idioms.title, idioms),
      ),
    ));
  }

  @override
  Future<void> savePhrasalVerbs(List<PhrasalVerbs> phrasalVerbs) async {
    await _appHive.phrasalVerbs.putAll(Map.fromEntries(
      phrasalVerbs.map(
        (phrasalVerbs) => MapEntry(phrasalVerbs.title, phrasalVerbs),
      ),
    ));
  }
}
