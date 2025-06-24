import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:get/get.dart';

class TopicRelatedScreenViewmodel extends GetViewModelBase {
  final _topicsRepo = Get.find<LearningCategoryRepositoryImpl>();
  late List<LearningCategory> topicsList;

  @override
  void onInit() {
    super.onInit();
    _onGetAllTopics();
  }

  _onGetAllTopics() {
    var list = _topicsRepo.getAllTopicCat();
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
