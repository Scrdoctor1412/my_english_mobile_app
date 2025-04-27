import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:englens/src/ui/screens/study/vocab/level_based/level_based_screen.dart';
import 'package:englens/src/ui/screens/study/vocab/topic_related/topic_related_screen.dart';
import 'package:get/get.dart';

class VocabScreenViewmodel extends GetViewModelBase {
  List<String> vocabularySection = [
    "Level-Based",
    "Topic-related",
  ];
  List<String> vocabularySectionScreenName = [
    LevelBasedScreen.routeName,
    TopicRelatedScreen.routeName,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
