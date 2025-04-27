import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:get/get.dart';

class TopicRelatedScreenViewmodel extends GetViewModelBase {
  final _topicsRepo = Get.find<TopicsRepositoryImpl>();
  late List<Topic> topicsList;

  @override
  void onInit() {
    super.onInit();
    _onGetAllTopics();
  }

  _onGetAllTopics() {
    var list = _topicsRepo.getAllTopics();
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
