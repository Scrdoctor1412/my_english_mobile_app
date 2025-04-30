import 'package:englens/src/configs/hive/app_hive.dart';
import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:englens/src/data/repositories/level_based_repository.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:englens/src/data/repositories/topics_repository.dart';
import 'package:get/get.dart';

class DI {
  static DI? _instance;

  DI._();

  factory DI() {
    _instance ??= DI._();
    return _instance!;
  }

  Future<void> init() async {
    //tools
    final appHive = AppHive();
    await appHive.init();

    Get.put(appHive);

    //controllers
    Get.put(HiveDatabase(appHive: appHive)); //local data
    Get.put(AssetsDataImpl());
    AssetsData assetsData = AssetsDataImpl();
    LocalData localData = HiveDatabase(appHive: appHive);
    Get.put(OxfordWordsRepositoryImpl(
        assetsData: assetsData, localData: localData));
    Get.put(TopicsRepositoryImpl(assetsData: assetsData, localData: localData));
    Get.put(
        LevelBasedRepositoryImpl(assetsData: assetsData, localData: localData));
    Get.put(ExpressionsRepositoryImpl(
        assetsData: assetsData, localData: localData));
  }
}
