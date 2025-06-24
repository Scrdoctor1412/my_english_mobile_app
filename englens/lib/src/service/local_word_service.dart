import 'dart:convert';

import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/level_based_repository.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalWordService {
  static final OxfordWordsRepositoryImpl _oxfordWordsRepositoryImpl =
      Get.find<OxfordWordsRepositoryImpl>();
  static final LearningCategoryRepositoryImpl _learningCategoryRepositoryImpl =
      Get.find<LearningCategoryRepositoryImpl>();

  static List<Word> oxfordWords = [];
  static List<Word> words = [];

  LocalWordService._();

  static Future<void> initData2() async {
    await Future.wait([
      _learningCategoryRepositoryImpl.initData(),
      _oxfordWordsRepositoryImpl.initData(),
    ]);

    var learningCategory =
        _learningCategoryRepositoryImpl.getAllLearningCategory();

    for (var item in learningCategory) {
      for (var lesson in item.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }

    oxfordWords = _oxfordWordsRepositoryImpl.getAllOxfordWords();

    words = [...words, ...oxfordWords];
    await getAllWordsFromLocal();
  }

  static Future<List<Word>> getAllWordsFromLocal() async {
    return await _learningCategoryRepositoryImpl.getAllWords();
  }

  static List<LearningCategory> getAllLearningCategory() {
    return _learningCategoryRepositoryImpl.getAllLearningCategory();
  }

  static List<Word> getAllOxfordWords() {
    return _oxfordWordsRepositoryImpl.getAllOxfordWords();
  }

  static void updateCategory(LearningCategory learningCategory) async {
    return _learningCategoryRepositoryImpl.updateCategory(learningCategory);
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
