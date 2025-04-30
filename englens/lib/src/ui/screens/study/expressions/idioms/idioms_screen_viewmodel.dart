import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:get/get.dart';

class IdiomsScreenViewmodel extends GetViewModelBase {
  final _expressionRepo = Get.find<ExpressionsRepositoryImpl>();
  late List<Idioms> idiomsList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idiomsList = _expressionRepo.getAllIdioms();
  }

  int countLessonWords(int index) {
    var lessons = idiomsList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
  }
}
