import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/settings/settings_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/settings/widget/settings_item_content_widget.dart';
import 'package:englens/src/ui/screens/settings/widget/settings_item_widget.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        var screenHeight = MediaQuery.of(context).size.height;

        _appBar() {
          return AppBar(
            toolbarHeight: 65,
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 32),
            ),
            automaticallyImplyLeading: false,
          );
        }

        // _bodyContent() {
        //   return Column(
        //     spacing: 16,
        //     children: [
        //       SizedBox(
        //         height: 120 * 1.5,
        //         width: 120 * 1.5,
        //         child: Image.asset(
        //           'assets/icons/app_icon_color_white_2.png',
        //           // scale: 1,
        //           // fit: BoxFit,
        //         ),
        //       ),
        //       SettingsItemWidget(
        //         icon: Icons.settings,
        //         title: 'General',
        //         children: [
        //           SettingsItemContentWidget(
        //             title: 'Notification',
        //             trailing: Switch(
        //               value: controller.notificationSwitchValue,
        //               inactiveThumbColor: ThemePrimary.grey,
        //               inactiveTrackColor: ThemePrimary.grey.withAlpha(40),
        //               trackOutlineColor:
        //                   WidgetStateProperty.resolveWith<Color?>(
        //                 (Set<WidgetState> states) {
        //                   // if (states.contains(WidgetState.disabled)) {
        //                   //   return Colors.orange.withOpacity(.48);
        //                   // }
        //                   return ThemePrimary.grey
        //                       .withAlpha(0); // Use the default color.
        //                 },
        //               ),
        //               onChanged: (value) {
        //                 controller.onTapToggleNotification();
        //               },
        //             ),
        //           ),
        //           SettingsItemContentWidget(
        //             title: 'Language',
        //             trailing: IconButton(
        //               onPressed: () {},
        //               icon: Icon(
        //                 Icons.chevron_right,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       SettingsItemWidget(
        //         title: 'Account',
        //         icon: Icons.person,
        //       ),
        //       SettingsItemWidget(
        //         title: 'Security',
        //         icon: Icons.verified_user,
        //       ),
        //       SettingsItemWidget(
        //         title: 'Contact us',
        //         icon: Icons.email,
        //       ),
        //       SettingsItemWidget(
        //         title: 'Logout',
        //         icon: Icons.logout,
        //         showTrailingIcon: false,
        //         isNotExpandable: true,
        //         onTap: () {
        //           // controller.signout();
        //           showCustomAlertDialog(
        //             context: context,
        //             title: 'Alert',
        //             content: 'Are you sure you want to logout?',
        //             onAccept: () {
        //               controller.signout();
        //               Navigator.of(context).pop();
        //             },
        //           );
        //         },
        //         // trailing: ,
        //       ),
        //     ],
        //   );
        // }

        _bodyContent2() {
          return Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications),
                    const SizedBox(width: 8),
                    Text(
                      'Notification',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                      value: controller.notificationSwitchValue,
                      onChanged: (value) {
                        controller.onTapToggleNotification();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.language),
                    const SizedBox(width: 8),
                    Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "vi/en",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: controller.languageSwitchValue,
                      onChanged: (value) {
                        controller.onTapToggleLanguage();
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Divider(
                  color: Colors.grey.withAlpha(120),
                ),
                InkWell(
                  onTap: () {
                    // controller.on
                    showCustomAlertDialog(
                      context: context,
                      title: 'Alert',
                      content: 'Are you sure you want to logout?',
                      onAccept: () {
                        controller.signout();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.logout),
                      const SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
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
                top: 80,
                right: 12,
                left: 12,
                bottom: 30,
                child: _bodyContent2(),
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
