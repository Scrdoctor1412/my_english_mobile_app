import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/learning_category.dart';
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
}

class LearningCategoryRepositoryImpl extends GetxController
    implements LearningCategoryRepository {
  final AssetsData _assetsData;
  final LocalData _localData;

  LearningCategoryRepositoryImpl({
    required AssetsData assetsData,
    required LocalData localData,
  })  : _assetsData = assetsData,
        _localData = localData;

  @override
  List<LearningCategory> getAllTopicCat() {
    var list = _localData.getLearningCategory();
    list = list
        .where(
          (element) => element.categoryType == CategoryType.topic,
        )
        .toList();
    return list;
  }

  @override
  List<LearningCategory> getAllLevelBasedCat() {
    var list = _localData.getLearningCategory();
    list = list
        .where(
          (element) => element.categoryType == CategoryType.levelBased,
        )
        .toList();
    return list;
  }

  @override
  List<LearningCategory> getAllIdiomsCat() {
    var list = _localData.getLearningCategory();
    list = list
        .where(
          (element) => element.categoryType == CategoryType.idioms,
        )
        .toList();
    return list;
  }

  @override
  List<LearningCategory> getAllCollocationsCat() {
    var list = _localData.getLearningCategory();
    list = list
        .where(
          (element) => element.categoryType == CategoryType.collocations,
        )
        .toList();
    return list;
  }

  @override
  List<LearningCategory> getAllEngProverbsCat() {
    var list = _localData.getLearningCategory();
    list = list
        .where(
          (element) => element.categoryType == CategoryType.engProverbs,
        )
        .toList();
    return list;
  }

  @override
  List<LearningCategory> getAllPhrasalVerbsCat() {
    var list = _localData.getLearningCategory();
    list = list
        .where(
          (element) => element.categoryType == CategoryType.engProverbs,
        )
        .toList();
    return list;
  }

  @override
  List<LearningCategory> getAllLearningCategory() {
    return _localData.getLearningCategory();
  }

  @override
  Future<void> initData() async {
    final currentLearningCategory = _localData.getLearningCategory();
    if (currentLearningCategory.isNotEmpty) return;

    final results = await Future.wait([
      _assetsData.getAllTopicsCat(),
      _assetsData.getAllLevelBasedCat(),
      _assetsData.getAllIdiomsCat(),
      _assetsData.getAllCollocationsCat(),
      _assetsData.getAllEngProverbsCat(),
      _assetsData.getAllPhrasalVerbsCat(),
    ]);

    // Gán kết quả cho các list
    List<LearningCategory> topics = results[0];
    List<LearningCategory> levelBased = results[1];
    List<LearningCategory> idioms = results[2];
    List<LearningCategory> collocations = results[3];
    List<LearningCategory> engProverbs = results[4];
    List<LearningCategory> phrasalVerbs = results[5];

    var learningCat = [
      ...topics,
      ...levelBased,
      ...idioms,
      ...collocations,
      ...engProverbs,
      ...phrasalVerbs
    ];

    await _localData.saveLearningCategories(learningCat);
  }
}
