import 'package:englens/src/app.dart';
import 'package:englens/src/configs/di.dart';

import 'package:englens/src/navigation/app_router.dart';

import 'package:englens/src/service/lang/translation_service.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(),
    DI().init(),
  ]);

  await TranslationService.init(const Locale('vi', 'en'));
  await LocalWordService.initData();

  // Set System UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Nvigate to default screen
  await AppRouter.navigateDefaultScreen();
  runApp(const MyApp());
}
