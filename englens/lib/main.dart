import 'package:englens/firebase_options.dart';
import 'package:englens/src/app.dart';
import 'package:englens/src/core/configs/di.dart';

import 'package:englens/src/navigation/app_router.dart';

import 'package:englens/src/core/service/lang/translation_service.dart';
import 'package:englens/src/core/service/learning_record_service.dart';
import 'package:englens/src/core/service/leitner_box_service.dart';
import 'package:englens/src/core/service/local_notification_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
  ]);

  await LocalNotificationService.requestPermissions();

  // Set System UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Nvigate to default screen
  // await AppRouter.navigateDefaultScreen();
  runApp(const MyApp());
}
