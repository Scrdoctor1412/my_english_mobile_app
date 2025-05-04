import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreenViewmodel extends GetViewModelBase {
  TextEditingController emailController = TextEditingController();
  AuthService authController = Get.put(AuthService());

  void onTapResetPassword() async {
    try {
      await authController.resetPassword(emailController.text);
    } catch (e) {
      print(e);
    }
  }
}
