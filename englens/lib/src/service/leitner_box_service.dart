import 'package:englens/src/data/models/leitner_box.dart';
import 'package:englens/src/data/repositories/leitner_box_repository.dart';
import 'package:get/get.dart';

class LeitnerBoxService {
  static final LeitnerBoxRepositoryImpl _leitnerBoxRepositoryImpl =
      Get.find<LeitnerBoxRepositoryImpl>();

  static List<LeitnerBox> leitnerBoxes = [];

  LeitnerBoxService._();

  static Future<void> initData() async {
    await _leitnerBoxRepositoryImpl.initData();
    leitnerBoxes = _leitnerBoxRepositoryImpl.getLeitnerBoxes();
    await saveLeitnerBoxes(leitnerBoxes);
  }

  static Future<void> saveLeitnerBoxes(List<LeitnerBox> leitnerBoxes) async {
    await _leitnerBoxRepositoryImpl.saveLeitnerBoxes(leitnerBoxes);
  }

  static void updateLeitnerBox(LeitnerBox leitnerBox) async {
    await _leitnerBoxRepositoryImpl.updateLeitnerBox(leitnerBox);
  }

  static List<LeitnerBox> getLeitnerBoxes() {
    return _leitnerBoxRepositoryImpl.getLeitnerBoxes();
  }

  static void addNewToLeitnerBox(String wordId) {
    leitnerBoxes[0] = leitnerBoxes[0].copyWith(
      wordIds: [...leitnerBoxes[0].wordIds!, wordId],
    );
    saveLeitnerBoxes(leitnerBoxes);
  }
}
