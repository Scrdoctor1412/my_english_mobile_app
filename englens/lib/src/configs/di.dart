import 'package:englens/src/configs/hive/app_hive.dart';
import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';

import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/learning_record_repository.dart';
import 'package:englens/src/data/repositories/leitner_box_repository.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';

import 'package:englens/src/service/firebase/word/word_service.dart';
import 'package:get/get.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';

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

    Get.put(AuthService());
    Get.put(WordService());

    //controllers
    Get.put(HiveDatabase(appHive: appHive)); //local data
    Get.put(AssetsDataImpl());
    AssetsData assetsData = AssetsDataImpl();
    LocalData localData = HiveDatabase(appHive: appHive);
    Get.put(OxfordWordsRepositoryImpl(
        assetsData: assetsData, localData: localData));
    // Get.put(TopicsRepositoryImpl(assetsData: assetsData, localData: localData));
    // Get.put(
    //     LevelBasedRepositoryImpl(assetsData: assetsData, localData: localData));
    // Get.put(ExpressionsRepositoryImpl(
    //     assetsData: assetsData, localData: localData));
    Get.put(LearningCategoryRepositoryImpl(
        assetsData: assetsData, localData: localData));
    Get.put(
        LeitnerBoxRepositoryImpl(assetsData: assetsData, localData: localData));
    Get.put(LearningRecordRepositoryImpl(localData: localData));
  }
}
