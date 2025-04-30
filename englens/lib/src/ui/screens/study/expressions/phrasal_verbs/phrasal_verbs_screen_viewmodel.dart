import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:get/get.dart';

class PhrasalVerbsScreenViewmodel extends GetViewModelBase {
  final _expressionRepo = Get.find<ExpressionsRepositoryImpl>();
  late List<PhrasalVerbs> phrasalVerbsList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phrasalVerbsList = _expressionRepo.getAllPhrasalverbs();
  }

  int countLessonWords(int index) {
    var lessons = phrasalVerbsList[index].lessons;
    int count = 0;
    for (var lesson in lessons!) {
      var words = lesson.wordList;
      count += words?.length ?? 0;
    }
    return count;
  }
}
