import 'package:englens/src/navigation/app_router.dart';
import 'package:englens/src/service/internet_connection_service.dart';
import 'package:englens/src/service/lang/translation_service.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRouter.INITIAL,
      getPages: AppRouter.routes,
      title: "Eng lens",
      theme: ThemePrimary.theme(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      enableLog: true,
      debugShowCheckedModeBanner: false,
      onInit: () {
        InternetConnectionService.instance();
      },
      locale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const <Locale>[Locale('en', ''), Locale('vi', '')],
    );
  }
}
