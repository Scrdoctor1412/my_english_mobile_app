import 'dart:convert';

import 'package:englens/src/data/models/learning_category.dart';

import 'package:englens/src/data/models/word.dart';

import 'package:englens/src/data/repositories/learning_category_repository.dart';

import 'package:englens/src/data/repositories/oxford_words_repository.dart';

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

  ///Hàm hỗ trợ lấy tất cả từ vựng có trong local
  static Future<List<Word>> getAllWordsFromLocal() async {
    return await _learningCategoryRepositoryImpl.getAllWords();
  }

  ///Hàm Hỗ trợ lấy tất cả các danh mục
  static List<LearningCategory> getAllLearningCategory() {
    return _learningCategoryRepositoryImpl.getAllLearningCategory();
  }

  ///Hàm hỗ trợ lấy các từ vựng Oxford
  static List<Word> getAllOxfordWords() {
    return _oxfordWordsRepositoryImpl.getAllOxfordWords();
  }

  ///Hàm hỗ trợ update danh mục từ vựng
  ///@param - LearningCategory learningCategory: object đanh mục từ vựng cần update
  static void updateCategory(LearningCategory learningCategory) async {
    return _learningCategoryRepositoryImpl.updateCategory(learningCategory);
  }

  ///Hám lấy từ
  ///@param - String wordId: id của từ
  static Future<Word> getWord(String wordId) async {
    var words = await LocalWordService.getAllWordsFromLocal();
    var word = words.firstWhere((element) => element.id == wordId);
    return word;
  }

  ///Hàm lưu từ
  ///@param - Word word: từ vựng
  static Future<bool> saveWord(Word word) async {
    return await _learningCategoryRepositoryImpl.saveWord(word);
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
