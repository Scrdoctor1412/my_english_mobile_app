import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/level_based_repository.dart';
import 'package:get/get.dart';

class LevelBasedScreenViewmodel extends GetViewModelBase {
  final _levelBasedRepo = Get.find<LearningCategoryRepositoryImpl>();
  late List<LearningCategory> levelBasedList;

  @override
  void onInit() {
    super.onInit();
    _onGetAllLevelBased();
  }

  _onGetAllLevelBased() {
    var list = _levelBasedRepo.getAllLevelBasedCat();
    levelBasedList = list;
    print(levelBasedList.length);
  }

  int countLessonWords(int index) {
    var lessons = levelBasedList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
  }
}
