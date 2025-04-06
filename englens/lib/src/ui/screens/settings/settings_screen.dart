import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/settings/settings_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenViewmodel>(
      init: SettingsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        // var screenHeight = MediaQuery.of(context).size.height;

        _appBar() {
          return AppBar(
            toolbarHeight: 65,
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 32),
            ),
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.white,
            // leading: Container(
            //   padding: const EdgeInsets.only(left: 12),
            //   height: 65,
            //   width: 65,
            //   child: ClipRRect(
            //       borderRadius: BorderRadius.circular(60),
            //       child: Image.asset('assets/images/launcher_icon.png')),
            // ),
          );
        }

        _generalSettingsContent() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 230),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // shape: Rounded,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: screenWidth,
            height: controller.generalMenuHeigth, //60,
            child: Column(
              mainAxisAlignment: !controller.isGeneralExpand
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: !controller.isGeneralExpand ? 0 : 24,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: ThemePrimary.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'General',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        controller.onTapToggleGeneralMenu();
                      },
                      child: Icon(
                        // CupertinoIcons.chevron_down,
                        !controller.isGeneralExpand
                            ? CupertinoIcons.chevron_right
                            : CupertinoIcons.chevron_down,
                        color: ThemePrimary.grey,
                      ),
                    ),
                  ],
                ),
                Offstage(
                  offstage: !controller.isGeneralExpand,
                  child: Row(
                    children: [
                      Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: controller.notificationSwitchValue,
                        inactiveThumbColor: ThemePrimary.grey,
                        inactiveTrackColor: ThemePrimary.grey.withAlpha(40),
                        trackOutlineColor:
                            WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                            // if (states.contains(WidgetState.disabled)) {
                            //   return Colors.orange.withOpacity(.48);
                            // }
                            return ThemePrimary.grey
                                .withAlpha(0); // Use the default color.
                          },
                        ),
                        onChanged: (value) {
                          controller.onTapToggleNotification();
                        },
                      )
                    ],
                  ),
                ),
                Offstage(
                  offstage: !controller.isGeneralExpand,
                  child: Row(
                    children: [
                      Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_down,
                        color: ThemePrimary.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        _accountSettingsContent() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // shape: Rounded,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: screenWidth,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: ThemePrimary.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: ThemePrimary.grey,
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        _securitySettingsContent() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // shape: Rounded,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: screenWidth,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: ThemePrimary.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Security',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: ThemePrimary.grey,
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        _contactUsSettingsContent() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // shape: Rounded,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: screenWidth,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: ThemePrimary.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Contact us',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: ThemePrimary.grey,
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        _logoutSettingsContent() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              // shape: Rounded,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(60),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: screenWidth,
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: ThemePrimary.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        controller.signout();
                      },
                      child: Icon(
                        CupertinoIcons.chevron_right,
                        color: ThemePrimary.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        _bodyContent() {
          return Column(
            spacing: 16,
            children: [
              SizedBox(
                height: 120 * 1.5,
                width: 120 * 1.5,
                child: Image.asset(
                  'assets/icons/app_icon_color_white_2.png',
                  // scale: 1,
                  // fit: BoxFit,
                ),
              ),
              _generalSettingsContent(),
              _accountSettingsContent(),
              _securitySettingsContent(),
              _contactUsSettingsContent(),
              _logoutSettingsContent()
            ],
          );
        }

        _body() {
          return Stack(
            children: [
              CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                painter: RPSCustomPainter(),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(child: _bodyContent()),
                ),
              )
            ],
          );
        }

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = ThemePrimary.primaryBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0009921, size.height * -0.0004167);
    path_0.quadraticBezierTo(size.width * -0.0002505, size.height * 0.2649521,
        size.width * -0.0006647, size.height * 0.3534083);
    path_0.cubicTo(
        size.width * 0.3838790,
        size.height * 0.2116917,
        size.width * 0.6127183,
        size.height * 0.4551292,
        size.width * 0.9990079,
        size.height * 0.2695833);
    path_0.quadraticBezierTo(size.width * 0.9987599, size.height * 0.2020833,
        size.width * 0.9980159, size.height * -0.0004167);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
