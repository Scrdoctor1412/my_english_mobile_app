import 'package:englens/src/core/base_view_model.dart';
import 'package:get/get.dart';

import '../../../service/firebase/auth/auth_service.dart';

class SettingsScreenViewmodel extends GetViewModelBase {
  AuthService authController = Get.put(AuthService());

  void signout() async {
    try {
      var res = await authController.signOut();
    } catch (e) {
      throw (e);
    }
  }
}
