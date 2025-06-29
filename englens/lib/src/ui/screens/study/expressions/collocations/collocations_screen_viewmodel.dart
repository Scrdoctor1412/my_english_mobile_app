import 'package:englens/src/core/base_view_model.dart';

import 'package:englens/src/data/models/learning_category.dart';

import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:get/get.dart';

class CollocationsScreenViewmodel extends GetViewModelBase {
  final _expressionRepo = Get.find<LearningCategoryRepositoryImpl>();
  late List<LearningCategory> collocationsList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    collocationsList = _expressionRepo.getAllCollocationsCat();
  }

  int countLessonWords(int index) {
    var lessons = collocationsList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
  }
}
