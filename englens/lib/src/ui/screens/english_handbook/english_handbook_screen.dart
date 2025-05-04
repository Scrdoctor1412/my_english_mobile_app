import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/custom_search_bar.dart';
import 'package:englens/src/ui/widget/english_card.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/lesson_details/lesson_details_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';

class EnglishHandbookScreen extends StatelessWidget {
  static const routeName = '/englishHandbookScreen';
  const EnglishHandbookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnglishHandbookScreenViewmodel>(
      init: EnglishHandbookScreenViewmodel(),
      builder: (controller) {
        controller.context = context;

        _appBar() {
          return AppBar(
            // primary: false,
            backgroundColor: ThemePrimary.successGreen,
            title: Text('English handbook'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              )
            ],
          );
        }

        _wordListTab() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // spacing: 10,
            children: [
              // const SizedBox(
              //   height: 12,
              // ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 230,
                      child: InkWell(
                        onTap: () {
                          // print(index);
                          Get.toNamed(
                            WordDetailsScreen.routeName,
                            arguments: WordDetailsScreenViewmodelArgs(
                              lessonTitle: '',
                              isFromLessonDetailsScreen: false,
                              onlyWord: [controller.wordList[index]],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: EnglishCard(
                            word: controller.wordList[index],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(),
                  itemCount: controller.wordList.length,
                ),
              )
            ],
          );
        }

        _body() {
          return Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
            ),
            child: Column(
              children: [
                CustomSearchBar(),
                Expanded(
                  child: _wordListTab(),
                ),
              ],
            ),
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

class TabsPainter extends CustomPainter {
  final TabController controller;
  final BuildContext context;
  // final List<double> widths;
  // final double height;
  double height = 48;
  TabsPainter({required this.controller, required this.context})
      : super(repaint: controller);

  // final List<double> widths = [89, 98, 111, 141, 108];
  double tabHeight = 50;
  double tabWidth = MediaQuery.of(Get.context!).size.width / 2;
  List<double> widths = [
    MediaQuery.of(Get.context!).size.width / 2,
    MediaQuery.of(Get.context!).size.width / 2
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final animation = controller.animation!.value;
    final dx = tabWidth * animation;

    final radius = 16.0;
    final notchWidth = 36.0;
    final notchDepth = 8.0;
    final centerX = dx + tabWidth / 2;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start từ top-left
    path.moveTo(dx + radius, 0);
    path.lineTo(dx + tabWidth - radius, 0);
    path.quadraticBezierTo(dx + tabWidth, 0, dx + tabWidth, radius);

    path.lineTo(dx + tabWidth, tabHeight - radius);
    path.quadraticBezierTo(
        dx + tabWidth, tabHeight, dx + tabWidth - radius, tabHeight);

    // Vẽ đến cạnh phải của lõm
    final rightOfNotch = centerX + notchWidth / 2;
    path.lineTo(rightOfNotch, tabHeight);

    // Vẽ lõm đáy ở giữa
    path.quadraticBezierTo(
      centerX,
      tabHeight - notchDepth,
      centerX - notchWidth / 2,
      tabHeight,
    );

    // Tiếp tục vẽ cạnh trái
    path.lineTo(dx + radius, tabHeight);
    path.quadraticBezierTo(dx, tabHeight, dx, tabHeight - radius);
    path.lineTo(dx, radius);
    path.quadraticBezierTo(dx, 0, dx + radius, 0);

    path.close();

    canvas.drawShadow(path, Colors.black26, 3, false);
    canvas.drawPath(path, paint);
  }

  double sumUntil(double animation) {
    double distance = 0;
    final index = animation.floor();
    for (int i = 0; i < index; i++) {
      distance += widths[i];
    }
    if (index < widths.length) {
      final leftover = animation - index;
      distance += leftover * widths[index];
    }
    return distance;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
