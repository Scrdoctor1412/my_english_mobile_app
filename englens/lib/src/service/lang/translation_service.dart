import 'dart:ui';

import 'package:englens/src/constants/app_constants.dart';
import 'package:englens/src/service/lang/en.dart';
import 'package:englens/src/service/lang/vi.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class TranslationService extends Translations {
  static var fallbackLocale = const Locale('vi', 'en');

  static String localToString(Locale locale) {
    return locale.languageCode + "-" + locale.countryCode.toString();
  }

  static Locale localFromString(String text) {
    var code = text.split("-");
    return Locale(code.first, code.last);
  }

  static Future<void> init(Locale locale) async {
    final SharedPreferences prefs = await _prefs;
    String? lang = prefs.getString(AppConstants.langKey);
    if (lang != null && lang.isNotEmpty) {
      fallbackLocale = localFromString(lang);
    } else {
      fallbackLocale = locale;
    }
  }

  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'vi': vi};

  static updateLocale(Locale locale) async {
    final SharedPreferences prefs = await _prefs;
    Get.updateLocale(locale);
    fallbackLocale = locale;
    prefs.setString(AppConstants.langKey, localToString(locale));
  }
}
