import 'package:englens/src/ui/screens/login/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenViewmodel>(
      init: LoginScreenViewmodel(),
      builder: (controller) {
        return Scaffold(body: Center(child: Text('new login screen')));
      },
    );
  }
}
