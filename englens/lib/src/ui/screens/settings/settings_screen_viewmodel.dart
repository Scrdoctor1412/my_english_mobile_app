import 'dart:ui';

import 'package:englens/src/core/constants/app_constants.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/core/service/lang/translation_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/service/firebase/auth/auth_service.dart';

class SettingsScreenViewmodel extends GetViewModelBase {
  AuthService authController = Get.put(AuthService());
  late SharedPreferences prefs;

  //general menu
  double generalMenuHeigth = 60;
  bool isGeneralExpand = false;
  bool notificationSwitchValue = false;
  bool languageSwitchValue = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();
    notificationSwitchValue =
        prefs.getBool(AppConstants.notificationKey) ?? false;
    // languageSwitchValue = prefs.getBool(AppConstants.langKey) ?? false;
    languageSwitchValue =
        (TranslationService.fallbackLocale.languageCode == 'vi') ? false : true;
    update();
  }

  void onTapToggleGeneralMenu() {
    isGeneralExpand = !isGeneralExpand;
    isGeneralExpand ? generalMenuHeigth = 175 : generalMenuHeigth = 60;
    update();
  }

  void onTapToggleNotification() {
    notificationSwitchValue = !notificationSwitchValue;
    prefs.setBool(AppConstants.notificationKey, notificationSwitchValue);
    update();
  }

  void onTapToggleLanguage() {
    languageSwitchValue = !languageSwitchValue;
    if (languageSwitchValue) {
      TranslationService.updateLocale(Locale("en", "US"));
    } else {
      TranslationService.updateLocale(Locale("vi", "VN"));
    }
    update();
  }

  void signout() async {
    try {
      await authController.signOut();
    } catch (e) {
      throw (e);
    }
  }
}
