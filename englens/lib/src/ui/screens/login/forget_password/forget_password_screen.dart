import 'package:englens/src/ui/screens/login/forget_password/forget_password_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordScreenViewmodel> {
  static const routeName = '/forgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    _appBar() {
      return AppBar(title: Text('Forget password'));
    }

    _body() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter email'),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email, color: Color(0xff868686)),
              hintText: 'Enter email',
              // filled: true,
              // fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                controller.onTapResetPassword();
              },
              child: Text('Forget password', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: _body(),
      ),
    );
  }
}
