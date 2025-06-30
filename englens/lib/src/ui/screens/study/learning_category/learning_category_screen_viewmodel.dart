import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';

import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_lessons/learning_category_lessons_screen.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_lessons/learning_category_lessons_screen_viewmodel.dart';

import 'package:get/get.dart';

enum LearningCategoryScreenType {
  vocabulary,
  expressions,
}

class LearningCategoryScreenViewArgs {
  final String title;
  final LearningCategoryScreenType screenType;

  LearningCategoryScreenViewArgs({
    required this.title,
    required this.screenType,
  });
}

class LearningCategoryScreenViewModel extends GetViewModelBase {
  String title = "";
  LearningCategoryScreenType screenType = LearningCategoryScreenType.vocabulary;

  final _learningCatRepo = Get.find<LearningCategoryRepositoryImpl>();
  late Map<String, List<LearningCategory>> learningCategoryMapList;

  List<String> vocabularySection = [
    "Level-Based",
    "Topic-related",
  ];

  List<CategoryType> catTypes = [];
  List<int> vocabSectionTopics = [];
  // List<String> vocabularySectionScreenName = [
  //   // LevelBasedScreen.routeName,
  //   // TopicRelatedScreen.routeName,
  // ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      final args = Get.arguments as LearningCategoryScreenViewArgs;
      title = args.title;
      screenType = args.screenType;
    }

    // vocabSectionTopics.add(levelBasedList.length);

    // vocabSectionTopics.add(topicList.length);
    initData();
  }

  void initData() {
    switch (screenType) {
      case LearningCategoryScreenType.vocabulary:
        var levelBasedList = _learningCatRepo.getAllLevelBasedCat();
        var topicList = _learningCatRepo.getAllTopicCat();
        vocabularySection = [
          "Level-Based",
          "Topic-related",
        ];
        learningCategoryMapList = {
          "Level-Based": levelBasedList,
          "Topic-related": topicList,
        };
        vocabSectionTopics = [levelBasedList.length, topicList.length];
        catTypes = [CategoryType.levelBased, CategoryType.topic];
        break;
      case LearningCategoryScreenType.expressions:
        var idioms = _learningCatRepo.getAllIdiomsCat();
        var collocations = _learningCatRepo.getAllCollocationsCat();
        var engProverbs = _learningCatRepo.getAllEngProverbsCat();
        var phrasalVerbs = _learningCatRepo.getAllPhrasalVerbsCat();

        vocabularySection = [
          "Idioms",
          "Collocations",
          "English Proverbs",
          "Phrasal verbs",
        ];
        learningCategoryMapList = {
          "Idioms": idioms,
          "Collocations": collocations,
          "English Proverbs": engProverbs,
          "Phrasal verbs": phrasalVerbs,
        };
        vocabSectionTopics = [
          idioms.length,
          collocations.length,
          engProverbs.length,
          phrasalVerbs.length,
        ];
        catTypes = [
          CategoryType.idioms,
          CategoryType.collocations,
          CategoryType.engProverbs,
          CategoryType.phraselVerbs,
        ];
        break;
    }
  }

  void onTapToCatLessons(int index) {
    Get.toNamed(
      LearningCategoryLessonsScreen.routeName,
      arguments: LearningCategoryLessonsScreenArgs(
        title: vocabularySection[index],
        catType: catTypes[index],
        screenType: screenType,
      ),
    );
  }
}
