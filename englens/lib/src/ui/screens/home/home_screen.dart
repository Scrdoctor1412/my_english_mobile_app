import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/english_card.dart';
import 'package:englens/src/ui/screens/home/home_screen_viewmodel.dart';

import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenViewmodel>(
      init: HomeScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _drawer() {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: ThemePrimary.primaryOrange),
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child:
                        Image.asset('assets/icons/app_icon_color_black_2.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.area_chart_rounded,
                    size: 32,
                    color: ThemePrimary.grey,
                  ),
                  title: const Text(
                    'Chart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.bar_chart,
                    size: 32,
                    color: ThemePrimary.grey,
                  ),
                  title: const Text(
                    'Ranking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          );
        }

        _userWordListBlock() {
          return InkWell(
            onTap: () {
              Get.toNamed(MyWordlistsScreen.routeName);
            },
            child: Container(
              width: screenWidth / 2.3,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(48),
                    offset: Offset(0, 2),
                    blurRadius: 10,
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.folder_copy_outlined,
                          color: Colors.orange,
                        ),
                        const Spacer(),
                        InkWell(
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'My WordLists',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        _wordBoxBlock() {
          return InkWell(
            onTap: () => controller.onTapToLeinerDailyWords(),
            child: Container(
              width: screenWidth / 2.3,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(48),
                    offset: Offset(0, 2),
                    blurRadius: 10,
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          // Icons.list_alt_rounded,
                          Icons.view_in_ar_rounded,
                          color: ThemePrimary.primaryOrange,
                        ),
                        // FaIcon(FontAwesomeIcons.cube),
                        const Spacer(),
                        // Container(
                        //   height: 26,
                        //   width: 26,
                        //   decoration: BoxDecoration(
                        //     color: ThemePrimary.primaryOrange,
                        //     borderRadius: BorderRadius.circular(50),
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       '2',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Daily words',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        _body() {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20),
            child: Container(
              height: screenHeight * 1.055,
              width: screenWidth,
              child: Stack(
                // fit: StackFit.,
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                    top: 40,
                    // right: 20,
                    left: screenWidth * 0.78,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            offset: Offset(1, 3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/launcher_icon.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                        controller.scaffoldKey.currentState!.openDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.white.withAlpha(90),
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -16,
                    left: 12,
                    right: 12,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        // width: 330,
                        height: 330,
                        child: Image.asset('assets/images/welcome_logo.png'),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 180,
                    // right: ,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Row(
                                children: [
                                  _userWordListBlock(),
                                  const Spacer(),
                                  _wordBoxBlock()
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.75,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(48),
                                    offset: Offset(0, 2),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'How many words have you learn today?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        height: 130,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 10,
                                          color: ThemePrimary.primaryOrange,
                                          backgroundColor:
                                              ThemePrimary.grey.withAlpha(50),
                                          strokeCap: StrokeCap.round,
                                          value: 0.5,
                                        ),
                                      ),
                                      Text(
                                        '2/5',
                                        style: TextStyle(
                                          fontSize: 40,
                                          letterSpacing: 3,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),
                          Flexible(
                            flex: 3,
                            child: Container(
                              // height: screenHeight * 0.4,
                              child: Column(
                                children: [
                                  Text(
                                    'Daily random 5 words for you!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          // height: 230,
                                          width: screenWidth * 0.9,
                                          child: InkWell(
                                            onTap: () => Get.toNamed(
                                              WordDetailsScreen.routeName,
                                              arguments:
                                                  WordDetailsScreenViewmodelArgs(
                                                isFromLessonDetailsScreen:
                                                    false,
                                                onlyWord: [
                                                  controller
                                                      .listRandomWords[index]
                                                ],
                                              ),
                                            ),
                                            child: EnglishCard(
                                                word: controller
                                                    .listRandomWords[index]),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: 20,
                                      ),
                                      itemCount:
                                          controller.listRandomWords.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  // Positioned.fill(child: const SizedBox(height: 20)),
                  // Container(height: 1000),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          key: controller.scaffoldKey,
          drawer: _drawer(),
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
      // ..color = const Color.fromARGB(255, 126, 134, 237)
      ..color = ThemePrimary.primaryBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0002963, size.height * 0.4972750);
    path_0.lineTo(size.width * -0.0009259, size.height * 0.0004167);
    path_0.lineTo(size.width * 1.0027778, size.height * -0.0005500);
    path_0.lineTo(size.width * 0.9993611, size.height * 0.4975167);
    path_0.quadraticBezierTo(size.width * 0.9696944, size.height * 0.5217542,
        size.width * 0.8824074, size.height * 0.5218833);
    path_0.cubicTo(
        size.width * 0.6849537,
        size.height * 0.5219875,
        size.width * 0.2949815,
        size.height * 0.5205458,
        size.width * 0.0975278,
        size.height * 0.5206500);
    path_0.quadraticBezierTo(size.width * 0.0347407, size.height * 0.5213167,
        size.width * -0.0002963, size.height * 0.4972750);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      // ..color = ThemePrimary.darkBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Layer 1

    Paint paint_fill_1 = Paint()
      // ..color = const Color.fromARGB(255, 68, 75, 173)
      ..color = ThemePrimary.darkBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 1.0009259, size.height * -0.0008333);
    path_1.quadraticBezierTo(size.width * 0.8030093, size.height * 0.0001042,
        size.width * 0.7370370, size.height * 0.0004167);
    path_1.cubicTo(
        size.width * 0.7938796,
        size.height * 0.0788125,
        size.width * 0.6154630,
        size.height * 0.1533875,
        size.width * 0.7018519,
        size.height * 0.1995833);
    path_1.quadraticBezierTo(size.width * 0.7681944, size.height * 0.2311042,
        size.width * 1.0018519, size.height * 0.2757417);

    canvas.drawPath(path_1, paint_fill_1);

    // Layer 1

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
