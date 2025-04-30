import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:get/get.dart';

class EngProverbsViewmodel extends GetViewModelBase {
  final _expressionRepo = Get.find<ExpressionsRepositoryImpl>();
  late List<EngProverbs> engProverbsList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    engProverbsList = _expressionRepo.getAllEngProverbs();
  }

  int countLessonWords(int index) {
    var lessons = engProverbsList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
  }
}
