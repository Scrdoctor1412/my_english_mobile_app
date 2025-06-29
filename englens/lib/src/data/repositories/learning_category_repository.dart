import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/utils/extensions/list_extensions.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

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
  Future<void> saveLearningCategories(List<LearningCategory> learningCategory);
  Future<void> updateCategory(LearningCategory learningCategory);
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
          (element) => element.categoryType == CategoryType.phraselVerbs,
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

    var uuid = Uuid();

    // Gán kết quả cho các list
    List<LearningCategory> topics = results[0].mapIndexed(
      (index, e) {
        e.id = uuid.v4();
        return e;
      },
    ).toList();
    List<LearningCategory> levelBased = results[1].mapIndexed(
      (index, e) {
        e.id = uuid.v4();
        return e;
      },
    ).toList();
    List<LearningCategory> idioms = results[2].mapIndexed(
      (index, e) {
        e.id = uuid.v4();
        return e;
      },
    ).toList();
    List<LearningCategory> collocations = results[3].mapIndexed(
      (index, e) {
        e.id = uuid.v4();
        return e;
      },
    ).toList();
    List<LearningCategory> engProverbs = results[4].mapIndexed(
      (index, e) {
        e.id = uuid.v4();
        return e;
      },
    ).toList();
    List<LearningCategory> phrasalVerbs = results[5].mapIndexed(
      (index, e) {
        e.id = uuid.v4();
        return e;
      },
    ).toList();

    List<Word> topicsWords = [];
    List<Word> levelBasedWords = [];
    List<Word> idiomsWords = [];
    List<Word> collocaitonsWords = [];
    List<Word> engProverbsWords = [];
    List<Word> phrasalVerbsWords = [];

    for (var item in topics) {
      for (var lesson in item.lessons!) {
        lesson.id = uuid.v4();
        for (var word in lesson.wordList!) {
          word.id = uuid.v4();
        }
        topicsWords.addAll(lesson.wordList!);
      }
    }

    for (var item in levelBased) {
      for (var lesson in item.lessons!) {
        lesson.id = uuid.v4();
        for (var word in lesson.wordList!) {
          word.id = uuid.v4();
        }
        levelBasedWords.addAll(lesson.wordList!);
      }
    }

    for (var item in idioms) {
      for (var lesson in item.lessons!) {
        lesson.id = uuid.v4();
        for (var word in lesson.wordList!) {
          word.id = uuid.v4();
        }
        idiomsWords.addAll(lesson.wordList!);
      }
    }

    for (var item in collocations) {
      for (var lesson in item.lessons!) {
        lesson.id = uuid.v4();
        for (var word in lesson.wordList!) {
          word.id = uuid.v4();
        }
        collocaitonsWords.addAll(lesson.wordList!);
      }
    }

    for (var item in engProverbs) {
      for (var lesson in item.lessons!) {
        lesson.id = uuid.v4();
        for (var word in lesson.wordList!) {
          word.id = uuid.v4();
        }
        engProverbsWords.addAll(lesson.wordList!);
      }
    }

    for (var item in phrasalVerbs) {
      for (var lesson in item.lessons!) {
        lesson.id = uuid.v4();
        for (var word in lesson.wordList!) {
          word.id = uuid.v4();
        }
        phrasalVerbsWords.addAll(lesson.wordList!);
      }
    }

    var learningCat = [
      ...topics,
      ...levelBased,
      ...idioms,
      ...collocations,
      ...engProverbs,
      ...phrasalVerbs
    ];

    var allWords = [
      ...topicsWords,
      ...levelBasedWords,
      ...idiomsWords,
      ...collocaitonsWords,
      ...engProverbsWords,
      ...phrasalVerbsWords
    ];

    await Future.wait([
      _localData.saveWords(allWords),
      _localData.saveLearningCategories(learningCat),
    ]);
  }

  @override
  Future<List<Word>> getAllWords() async {
    final currentWords = _localData.getWords();
    return currentWords;
    // if (currentWords.isNotEmpty && currentWords.length > 5946)
    //   return currentWords;
    // return [];
    // var uuid = Uuid();
    // final results = await Future.wait([
    //   _assetsData.getAllTopicsWords(),
    //   _assetsData.getAllLevelBasedWords(),
    //   _assetsData.getAllIdiomsWords(),
    //   _assetsData.getAllCollocationsWords(),
    //   _assetsData.getAllEngProverbsWords(),
    //   _assetsData.getAllPhrasalVerbsWords(),
    // ]);
    // List<Word> topics = results[0].mapIndexed(
    //   (index, word) {
    //     word.id = uuid.v4();

    //     return word;
    //   },
    // ).toList();
    // List<Word> levelBased = results[1].mapIndexed(
    //   (index, word) {
    //     word.id = uuid.v4();

    //     return word;
    //   },
    // ).toList();
    // List<Word> idioms = results[2].mapIndexed(
    //   (index, word) {
    //     word.id = uuid.v4();

    //     return word;
    //   },
    // ).toList();
    // List<Word> collocations = results[3].mapIndexed(
    //   (index, word) {
    //     word.id = uuid.v4();

    //     return word;
    //   },
    // ).toList();
    // List<Word> engProverbs = results[4].mapIndexed(
    //   (index, word) {
    //     word.id = uuid.v4();

    //     return word;
    //   },
    // ).toList();

    // List<Word> phrasalVerbs = results[5].mapIndexed(
    //   (index, word) {
    //     word.id = uuid.v4();

    //     return word;
    //   },
    // ).toList();

    // var words = [
    //   ...currentWords,
    //   ...topics,
    //   ...levelBased,
    //   ...idioms,
    //   ...collocations,
    //   ...engProverbs,
    //   ...phrasalVerbs
    // ];
    // await _localData.saveWords(words);
    // return words;
  }

  @override
  Future<void> saveLearningCategories(
      List<LearningCategory> learningCategory) async {
    await _localData.saveLearningCategories(learningCategory);
  }

  @override
  Future<void> updateCategory(LearningCategory learningCategory) async {
    await _localData.updateLearningCategory(learningCategory);
  }
}
