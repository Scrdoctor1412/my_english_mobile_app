import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:get/get.dart';

class CollocationsScreenViewmodel extends GetViewModelBase {
  final _expressionRepo = Get.find<ExpressionsRepositoryImpl>();
  late List<Collocations> collocationsList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    collocationsList = _expressionRepo.getAllCollocations();
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
