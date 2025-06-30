// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/ui/screens/study/learning_category/learning_category_screen.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_screen_viewmodel.dart';
import 'package:get/get.dart';

import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';

class LearningCategoryLessonsScreenArgs {
  final String title;
  final CategoryType catType;
  final LearningCategoryScreenType screenType;

  LearningCategoryLessonsScreenArgs({
    required this.title,
    required this.catType,
    required this.screenType,
  });
}

class LearningCategoryLessonsScreenViewmodel extends GetViewModelBase {
  final _topicsRepo = Get.find<LearningCategoryRepositoryImpl>();
  late List<LearningCategory> topicsList;
  late String title;
  late CategoryType catType;
  late LearningCategoryScreenType screenType;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      LearningCategoryLessonsScreenArgs args =
          Get.arguments as LearningCategoryLessonsScreenArgs;
      title = args.title;
      catType = args.catType;
      screenType = args.screenType;
    }
    _onGetAllTopics();
  }

  String getImageLink(String title) {
    String link = "";
    switch (catType) {
      case CategoryType.topic:
        link = 'assets/images/topics/$title.jpg';
        break;
      case CategoryType.levelBased:
        link = 'assets/images/level_based/$title.jpg';
        break;
      case CategoryType.idioms:
        link = 'assets/images/expressions/idioms/$title.jpg';
        break;
      case CategoryType.collocations:
        link = 'assets/images/expressions/collocations/$title.jpg';
        break;
      case CategoryType.engProverbs:
        link = 'assets/images/expressions/eng_proverbs/$title.jpg';
        break;
      case CategoryType.phraselVerbs:
        link = 'assets/images/expressions/phrasal_verbs/$title.jpg';

        break;
    }
    return link;
  }

  _onGetAllTopics() {
    List<LearningCategory> list = [];
    switch (catType) {
      case CategoryType.topic:
        list = _topicsRepo.getAllTopicCat();
        break;
      case CategoryType.levelBased:
        list = _topicsRepo.getAllLevelBasedCat();
        break;
      case CategoryType.idioms:
        list = _topicsRepo.getAllIdiomsCat();
        break;
      case CategoryType.collocations:
        list = _topicsRepo.getAllCollocationsCat();
        break;
      case CategoryType.engProverbs:
        list = _topicsRepo.getAllEngProverbsCat();
        break;
      case CategoryType.phraselVerbs:
        list = _topicsRepo.getAllPhrasalVerbsCat();
        break;
    }
    topicsList = list;
    print(topicsList.length);
    // _calculateLessonsWords();
  }

  int countLessonWords(int index) {
    var lessons = topicsList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
  }
}
