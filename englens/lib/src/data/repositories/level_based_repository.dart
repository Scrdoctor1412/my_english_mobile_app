import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/level_based.dart';

import 'package:get/get.dart';

abstract interface class LevelBasedRepository {
  Future<void> initData();

  List<LevelBased> getAllLevelBased();
}

class LevelBasedRepositoryImpl extends GetxController
    implements LevelBasedRepository {
  final AssetsData _assetsData;
  final LocalData _localData;

  LevelBasedRepositoryImpl({
    required AssetsData assetsData,
    required LocalData localData,
  })  : _assetsData = assetsData,
        _localData = localData;

  @override
  List<LevelBased> getAllLevelBased() {
    // TODO: implement getAllLevelBased
    return _localData.getLevelBased();
  }

  @override
  Future<void> initData() async {
    final currentLevelBased = _localData.getLevelBased();
    if (currentLevelBased.isNotEmpty) return;
    final levelBased = await _assetsData.getAllLevelBased();
    await _localData.saveLevelBased(levelBased);
  }
}
