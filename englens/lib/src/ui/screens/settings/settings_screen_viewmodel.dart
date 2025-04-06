import 'package:englens/src/core/base_view_model.dart';
import 'package:get/get.dart';

import '../../../service/firebase/auth/auth_service.dart';

class SettingsScreenViewmodel extends GetViewModelBase {
  AuthService authController = Get.put(AuthService());

  //general menu
  double generalMenuHeigth = 60;
  bool isGeneralExpand = false;
  bool notificationSwitchValue = false;

  void onTapToggleGeneralMenu() {
    isGeneralExpand = !isGeneralExpand;
    isGeneralExpand ? generalMenuHeigth = 175 : generalMenuHeigth = 60;
    update();
  }

  void onTapToggleNotification() {
    notificationSwitchValue = !notificationSwitchValue;
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
