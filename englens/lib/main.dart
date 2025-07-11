import 'package:englens/src/app.dart';
import 'package:englens/src/configs/di.dart';
import 'package:englens/src/data/models/learning_record.dart';

import 'package:englens/src/navigation/app_router.dart';

import 'package:englens/src/service/lang/translation_service.dart';
import 'package:englens/src/service/learning_record_service.dart';
import 'package:englens/src/service/leitner_box_service.dart';
import 'package:englens/src/service/local_notification_service.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Future.wait([
    TranslationService.init(const Locale('vi', 'en')),
    DI().init(),
    LocalNotificationService.init(),

    // LocalWordService.initData2()
  ]);

  // await TranslationService.init(const Locale('vi', 'en'));
  await Future.wait([
    LearningRecordService.initData(),
    LeitnerBoxService.initData(),
    LocalWordService.initData2(),
  ]);

  await LocalNotificationService.requestPermissions();

  // Set System UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Nvigate to default screen
  await AppRouter.navigateDefaultScreen();
  runApp(const MyApp());
}
