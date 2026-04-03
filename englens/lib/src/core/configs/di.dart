import 'package:englens/src/core/configs/hive/app_hive.dart';

import 'package:englens/src/data/data_sources/local_data.dart';

import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/learning_record_repository.dart';
import 'package:englens/src/data/repositories/leitner_box_repository.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';

import 'package:englens/src/core/service/firebase/word/word_service.dart';
import 'package:get/get.dart';
import 'package:englens/src/core/service/firebase/auth/auth_service.dart';

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

    LocalData localData = HiveDatabase(appHive: appHive);
    Get.put(OxfordWordsRepositoryImpl(localData: localData));

    Get.put(LearningCategoryRepositoryImpl(localData: localData));
    Get.put(LeitnerBoxRepositoryImpl(localData: localData));
    Get.put(LearningRecordRepositoryImpl(localData: localData));
  }
}
