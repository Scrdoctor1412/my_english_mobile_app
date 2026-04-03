import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/login/register/register_screen_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterScreenViewmodel> {
  static const routeName = '/registerScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    _appBar() {
      return AppBar(title: Text('Register'));
    }

    Widget CustomTextFormField({
      required TextEditingController controller,
      required Function(String?) validator,
      bool obscureText = false,
      bool enableSuggestions = true,
      bool autocorrect = true,
      IconData? prefixIcon,
      IconData? suffixIcon,
      Function? suffixIconTap,
      required String label,
      String? hintText,
    }) {
      return TextFormField(
        controller: controller,
        validator: (value) {
          return validator(value);
        },
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon ?? Icons.email, color: Color(0xff868686)),
          suffixIcon: GestureDetector(
            onTap: () {
              // controller.onToggleShowPassword();
              suffixIconTap!();
            },
            child: Icon(suffixIcon, color: Color(0xff868686)),
          ),
          label: Text(label),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
        ),
      );
    }

    _body() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              const SizedBox(height: 40),
              Image.asset('assets/images/join_us.png'),
              const SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  // Text('Email'),
                  CustomTextFormField(
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'Email is required';
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value);

                      if (!emailValid) {
                        return 'Please enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    label: 'Email',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  // Text('Password'),
                  CustomTextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isObsecureText,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return 'Password is required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                    label: 'Password',
                    prefixIcon: Icons.password,
                    suffixIcon: Icons.visibility,
                    suffixIconTap: controller.onToggleShowPassword,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: screenWidth,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    controller.onTapRegister();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text('Register'),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(text: " "),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(color: ThemePrimary.primaryBlue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // controller.onTapToResgisterScreen();
                            controller.onTapToSignIn();
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      // appBar: _appBar(),
      body: SingleChildScrollView(child: _body()),
    );
  }
}
