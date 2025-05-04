import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/login/login_screen_viewmodel.dart';
import 'package:flutter/gestures.dart';
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
        controller.context = context;
        var screenHeight = MediaQuery.of(context).size.height;
        // var screenWidth = MediaQuery.of(context).size.width;

        _orBlock() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: ThemePrimary.grey.withAlpha(80),
                  thickness: 2,
                  height: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'LOGIN_SCREEN.OR'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: ThemePrimary.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Divider(
                  color: ThemePrimary.grey.withAlpha(80),
                  thickness: 2,
                  height: 20,
                ),
              ),
            ],
          );
        }

        _googleSignin() {
          return InkWell(
            onTap: () {
              controller.onLoginWithGoogle();
            },
            radius: 10,
            child: SizedBox(
              height: 75,
              width: 75,
              child: Image.asset('assets/icons/google_icon.png'),
            ),
          );
        }

        _body() {
          return SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('New login screen'),
                  // Image.asset('assets/images/test.jpg'),
                  Image.asset('assets/images/launcher_icon_no_bg.png'),
                  SizedBox(height: screenHeight * 0.035),
                  TextFormField(
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'LOGIN_SCREEN.EMAIL_BLANK'.tr;
                      } else {
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'LOGIN_SCREEN.EMAIL_ERROR'.tr;
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xff868686),
                      ),
                      label: Text('LOGIN_SCREEN.EMAIL'.tr),
                      hintText: 'LOGIN_SCREEN.EMAIL_HINT'.tr,
                      // filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'LOGIN_SCREEN.PASSWORD_BLANK'.tr;
                      }
                      return null;
                    },
                    obscureText: controller.isObsecureText,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xff868686),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.onToggleShowPassword();
                        },
                        child: Icon(
                          Icons.remove_red_eye_sharp,
                          color: Color(0xff868686),
                        ),
                      ),
                      label: Text('LOGIN_SCREEN.PASSWORD'.tr),
                      hintText: 'LOGIN_SCREEN.PASSWORD_HINT'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          )),
                      onPressed: () {
                        controller.onLogin();
                      },
                      child: Text(
                        'LOGIN_SCREEN.SIGNIN'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Không có tài khoản?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Đăng ký",
                          style: TextStyle(
                            color: ThemePrimary.primaryBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.onTapToResgisterScreen();
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  _orBlock(),
                  const SizedBox(height: 12),
                  _googleSignin(),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      controller.onTapToForgetPasswordScreen();
                    },
                    child: Text(
                      'LOGIN_SCREEN.FORGOT_PASSWORD'.tr,
                      style: TextStyle(
                        color: ThemePrimary.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: _body(),
          ),
        );
      },
    );
  }
}
