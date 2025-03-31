import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:get/get.dart';

class TabsScreenViewmodel extends GetViewModelBase {
  AuthService authController = Get.put(AuthService());

  void signout() async {
    try {
      var res = await authController.signOut();
    } catch (e) {
      throw (e);
    }
  }
}
