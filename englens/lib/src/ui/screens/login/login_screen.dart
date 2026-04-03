import 'package:englens/src/ui/screens/login/login_screen_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginScreenViewmodel> {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    final Color primaryPurple = const Color(0xFF6B4EFF);
    final Color inputFillColor = const Color(0xFFEFEAF9);
    final Color textGrey = const Color(0xff868686);

    Widget _orBlock() {
      return Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'HOẶC',
              style: TextStyle(
                fontSize: 10,
                color: textGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        ],
      );
    }

    Widget _googleSignin() {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF8F5FF),
            foregroundColor: Colors.black87,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Image.asset(
            'assets/icons/google_icon.png',
            height: 50,
            width: 50,
          ),
          label: const Text(
            'Tiếp tục với Google',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            controller.onLoginWithGoogle();
          },
        ),
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  // color: primaryPurple,
                  borderRadius: BorderRadius.circular(16),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: primaryPurple.withOpacity(0.3),
                  //     blurRadius: 15,
                  //     offset: const Offset(0, 5),
                  //   ),
                  // ],
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/launcher_icon_no_bg.png',
                  // width: 65,
                  // height: 65,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'ENGLENS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Linguistic Clarity, Mastered.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Chào mừng trở lại',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'LOGIN_SCREEN.EMAIL_BLANK'.tr;
                        } else {
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                          if (!emailValid) {
                            return 'LOGIN_SCREEN.EMAIL_ERROR'.tr;
                          }
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: textGrey.withOpacity(0.7),
                          size: 20,
                        ),
                        hintText: 'name@example.com',
                        hintStyle: TextStyle(
                          color: textGrey.withOpacity(0.7),
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: inputFillColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mật khẩu',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'LOGIN_SCREEN.PASSWORD_BLANK'.tr;
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: controller.isObsecureText,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: textGrey.withOpacity(0.7),
                          size: 20,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.onToggleShowPassword();
                          },
                          child: Icon(
                            Icons.remove_red_eye_sharp,
                            color: textGrey.withOpacity(0.7),
                            size: 20,
                          ),
                        ),
                        hintText: '••••••••',
                        hintStyle: TextStyle(
                          color: textGrey.withOpacity(0.7),
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                        filled: true,
                        fillColor: inputFillColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          controller.onTapToForgetPasswordScreen();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'QUÊN MẬT KHẨU?',
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryPurple,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          controller.onLogin();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Đăng nhập'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _orBlock(),
                    const SizedBox(height: 24),
                    _googleSignin(),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Không có tài khoản? ',
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                    TextSpan(
                      text: "Đăng ký",
                      style: TextStyle(
                        color: primaryPurple,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.onTapToResgisterScreen();
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFF3EEFD), Color(0xFFE2EAF8)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _body(),
          ),
        ),
      ),
    );
  }
}
