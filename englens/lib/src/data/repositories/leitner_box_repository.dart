import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/leitner_box.dart';
import 'package:get/get.dart';

abstract interface class LeitnerBoxRepository {
  Future<void> saveLeitnerBoxes(List<LeitnerBox> leitnerBoxes);

  List<LeitnerBox> getLeitnerBoxes();

  Future<void> updateLeitnerBox(LeitnerBox leitnerBox);

  Future<void> initData();
}

class LeitnerBoxRepositoryImpl extends GetxController
    implements LeitnerBoxRepository {
  final LocalData _localData;

  LeitnerBoxRepositoryImpl({required LocalData localData})
    : _localData = localData;
  @override
  List<LeitnerBox> getLeitnerBoxes() {
    var list = _localData.getLeitnerBoxes();
    return list;
  }

  @override
  Future<void> saveLeitnerBoxes(List<LeitnerBox> leitnerBoxes) async {
    await _localData.saveLeitnerBoxes(leitnerBoxes);
  }

  @override
  Future<void> updateLeitnerBox(LeitnerBox leitnerBox) async {
    await _localData.updateLeitnerBox(leitnerBox);
  }

  @override
  Future<void> initData() async {
    var currentLeitnerBoxes = _localData.getLeitnerBoxes();
    if (currentLeitnerBoxes.isNotEmpty) return;
    List<LeitnerBox> leitnerBoxes = [];
    for (var i = 0; i < 8; i++) {
      leitnerBoxes.add(
        LeitnerBox(
          index: i,
          boxType: LeitnerBoxType.values[i],
          wordIds: [],
          lastLearned: DateTime.now().toIso8601String(),
        ),
      );
    }
    await _localData.saveLeitnerBoxes(leitnerBoxes);
  }
}
