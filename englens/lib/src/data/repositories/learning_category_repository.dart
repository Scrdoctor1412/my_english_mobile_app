import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

abstract interface class LearningCategoryRepository {
  Future<void> initData();
  List<LearningCategory> getAllLearningCategory();
  List<LearningCategory> getAllTopicCat();
  List<LearningCategory> getAllLevelBasedCat();
  List<LearningCategory> getAllIdiomsCat();
  List<LearningCategory> getAllCollocationsCat();
  List<LearningCategory> getAllEngProverbsCat();
  List<LearningCategory> getAllPhrasalVerbsCat();

  Future<List<Word>> getAllWords();
  Future<bool> saveWord(Word word); // Cập nhật từ vựng (ví dụ đổi trạng thái)
  Future<void> updateCategory(LearningCategory learningCategory);
}

class LearningCategoryRepositoryImpl extends GetxController
    implements LearningCategoryRepository {
  // KHÔNG CÒN AssetsData NỮA
  final LocalData _localData;

  LearningCategoryRepositoryImpl({required LocalData localData})
    : _localData = localData;

  @override
  Future<void> initData() async {
    // KHÔNG LÀM GÌ CẢ!
    // Dữ liệu đã được AppHive copy sẵn từ file .hive đóng gói từ trước.
    return;
  }

  @override
  List<LearningCategory> getAllTopicCat() {
    return _localData
        .getLearningCategory()
        .where((element) => element.categoryType == CategoryType.topic)
        .toList();
  }

  @override
  List<LearningCategory> getAllLevelBasedCat() {
    return _localData
        .getLearningCategory()
        .where((element) => element.categoryType == CategoryType.levelBased)
        .toList();
  }

  @override
  List<LearningCategory> getAllIdiomsCat() {
    return _localData
        .getLearningCategory()
        .where((element) => element.categoryType == CategoryType.idioms)
        .toList();
  }

  @override
  List<LearningCategory> getAllCollocationsCat() {
    return _localData
        .getLearningCategory()
        .where((element) => element.categoryType == CategoryType.collocations)
        .toList();
  }

  @override
  List<LearningCategory> getAllEngProverbsCat() {
    return _localData
        .getLearningCategory()
        .where((element) => element.categoryType == CategoryType.engProverbs)
        .toList();
  }

  @override
  List<LearningCategory> getAllPhrasalVerbsCat() {
    return _localData
        .getLearningCategory()
        .where((element) => element.categoryType == CategoryType.phraselVerbs)
        .toList();
  }

  @override
  List<LearningCategory> getAllLearningCategory() =>
      _localData.getLearningCategory();

  @override
  Future<List<Word>> getAllWords() async => _localData.getWords();

  @override
  Future<void> updateCategory(LearningCategory learningCategory) async {
    await _localData.updateLearningCategory(learningCategory);
  }

  @override
  Future<bool> saveWord(Word word) async {
    try {
      await _localData.saveWord(word);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
