import 'dart:convert';

import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:englens/src/data/repositories/level_based_repository.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalWordService {
  static final ExpressionsRepositoryImpl _expressionsRepositoryImpl =
      Get.find<ExpressionsRepositoryImpl>();
  static final LevelBasedRepositoryImpl _levelBasedRepositoryImpl =
      Get.find<LevelBasedRepositoryImpl>();
  static final TopicsRepositoryImpl _topicsRepositoryImpl =
      Get.find<TopicsRepositoryImpl>();
  static final OxfordWordsRepositoryImpl _oxfordWordsRepositoryImpl =
      Get.find<OxfordWordsRepositoryImpl>();

  static List<LevelBased> listLevelBased = [];
  static List<Topic> listTopics = [];
  static List<Idioms> listIdioms = [];
  static List<EngProverbs> listEngProverbs = [];
  static List<Collocations> listCollocations = [];
  static List<PhrasalVerbs> listPhrasalVerbs = [];
  static List<Word> oxfordWords = [];
  static List<Word> words = [];

  LocalWordService._();

  static Future<void> initData() async {
    await Future.wait([
      _expressionsRepositoryImpl.initData(),
      _levelBasedRepositoryImpl.initData(),
      _topicsRepositoryImpl.initData(),
      _oxfordWordsRepositoryImpl.initData(),
    ]);

    listLevelBased = _levelBasedRepositoryImpl.getAllLevelBased();
    listTopics = _topicsRepositoryImpl.getAllTopics();
    listIdioms = _expressionsRepositoryImpl.getAllIdioms();
    listEngProverbs = _expressionsRepositoryImpl.getAllEngProverbs();
    listCollocations = _expressionsRepositoryImpl.getAllCollocations();
    listPhrasalVerbs = _expressionsRepositoryImpl.getAllPhrasalverbs();
    oxfordWords = _oxfordWordsRepositoryImpl.getAllOxfordWords();

    for (var topic in listLevelBased) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }

    for (var topic in listTopics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }

    for (var topic in listIdioms) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }

    for (var topic in listEngProverbs) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }

    for (var topic in listCollocations) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    for (var topic in listPhrasalVerbs) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    words = [...words, ...oxfordWords];

    // await saveListWordToGlobalWordList(words);
  }

  static List<Word> getAllWordsFromLocal() {
    return words;
  }

  //Hàm lưu danh sách từ vựng tổng từ local
  static Future<void> saveListWordToGlobalWordList(List<Word> words) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> wordStrings = prefs.getStringList('global_word_list') ?? [];

    List<String> newWordsString = words
        .map(
          (word) => jsonEncode(word.toJson()),
        )
        .toList();

    wordStrings = [...wordStrings, ...newWordsString];

    prefs.setStringList('global_word_list', wordStrings);
  }

  //Hàm lấy danh sách từ vựng tổng từ local
  static Future<List<Word>> getGlobalWordList() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? wordStrings = prefs.getStringList('global_word_list');

    if (wordStrings == null) {
      return [];
    }

    List<Word> words = wordStrings.map((wordString) {
      return Word.fromJson(jsonDecode(wordString));
    }).toList();

    return words;
  }
}
