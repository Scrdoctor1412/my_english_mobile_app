import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/core/service/firebase/auth/auth_service.dart';
import 'package:englens/src/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreenViewmodel extends GetViewModelBase {
  final _authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();

  bool isObsecureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onToggleShowPassword() {
    isObsecureText = !isObsecureText;
    update();
  }

  void onTapToSignIn() {
    Get.offAllNamed(LoginScreen.routeName);
  }

  void onTapRegister() async {
    if (formKey.currentState!.validate()) {
      try {
        var res = await _authService.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // if (res != null) {
        //   Get.offAllNamed(LoginScreen.routeName);
        // }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
