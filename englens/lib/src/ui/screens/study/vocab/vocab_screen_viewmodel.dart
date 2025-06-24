import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/level_based_repository.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:englens/src/ui/screens/study/vocab/level_based/level_based_screen.dart';
import 'package:englens/src/ui/screens/study/vocab/topic_related/topic_related_screen.dart';
import 'package:get/get.dart';

class VocabScreenViewmodel extends GetViewModelBase {
  final _learningCatRepo = Get.find<LearningCategoryRepositoryImpl>();
  late List<LearningCategory> topicList;
  late List<LearningCategory> levelBasedList;
  List<String> vocabularySection = [
    "Level-Based",
    "Topic-related",
  ];
  List<int> vocabSectionTopics = [];
  List<String> vocabularySectionScreenName = [
    LevelBasedScreen.routeName,
    TopicRelatedScreen.routeName,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    levelBasedList = _learningCatRepo.getAllLevelBasedCat();
    vocabSectionTopics.add(levelBasedList.length);
    topicList = _learningCatRepo.getAllTopicCat();
    vocabSectionTopics.add(topicList.length);
  }
}
