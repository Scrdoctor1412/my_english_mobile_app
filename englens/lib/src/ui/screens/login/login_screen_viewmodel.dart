import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/core/service/firebase/auth/auth_service.dart';
import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/login/register/register_screen.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/ui/screens/login/forget_password/forget_password_screen.dart';
import 'package:englens/src/ui/screens/tabs/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginScreenViewmodel extends GetViewModelBase {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObsecureText = true;

  AuthService authService = Get.put(AuthService());

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onToggleShowPassword() {
    isObsecureText = !isObsecureText;
    update();
  }

  void onTapToForgetPasswordScreen() {
    Get.toNamed(ForgetPasswordScreen.routeName);
  }

  void onTapToResgisterScreen() {
    Get.toNamed(RegisterScreen.routeName);
  }

  void onLoginWithGoogle() async {
    try {
      ShowLoadingDialog.showLoadingDialog(
        context: Get.context!,
        loadingText: 'Logging in',
      );
      var res = await authService.loginWithGoogle();

      if (res == true) {
        // ShowLoadingDialog.hideLoadingDialog(context: Get.context!);

        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: ThemePrimary.darkBlue,
            content: Text(
              'Login success',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        ShowLoadingDialog.hideLoadingDialog(context: Get.context!);

        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: ThemePrimary.darkBlue,
            content: Text(
              'Login denied',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    } catch (e) {
      ShowLoadingDialog.hideLoadingDialog(context: Get.context!);
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: ThemePrimary.darkBlue,
          content: Text(
            'Email or password incorrect',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  void onLogin() async {
    // ShowLoadingDialog.showLoadingDialog(
    //     context: Get.context!, loadingText: 'Loging in');
    if (formKey.currentState!.validate()) {
      ShowLoadingDialog.showLoadingDialog(
        context: Get.context!,
        loadingText: 'Logging in',
      );
      try {
        var email = emailController.text;
        var password = passwordController.text;
        var res = await authService.signInWithEmailandPassword(email, password);

        if (res.user != null) {
          ShowLoadingDialog.hideLoadingDialog(context: Get.context!);
          Get.offAllNamed(TabsScreen.routeName);
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              backgroundColor: ThemePrimary.darkBlue,
              content: Text(
                'Login success',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      } catch (e) {
        ShowLoadingDialog.hideLoadingDialog(context: Get.context!);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: ThemePrimary.darkBlue,
            content: Text(
              'Email or password incorrect',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }
  }
}
