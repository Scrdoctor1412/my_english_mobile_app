import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/common/english_card.dart';
import 'package:englens/src/ui/screens/home/home_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/home/word_search/word_search_screen.dart';
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

        _body() {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
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
                      // Scaffold.of(context).openDrawer();
                      controller.scaffoldKey.currentState!.openDrawer();
                      print('lmao');
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
                Positioned.fill(
                  top: 150,
                  // right: ,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, User!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: screenWidth,
                          height: 65,
                          child: Hero(
                            tag: "search_text_field",
                            child: Material(
                              color: Colors.transparent,
                              child: TextField(
                                onTap: () {
                                  Get.toNamed(WordSearchScreen.routeName);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'What word will you search today?',
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: ThemePrimary.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: ThemePrimary.grey,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent.withAlpha(0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent.withAlpha(0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent.withAlpha(0),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent.withAlpha(0),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent.withAlpha(0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: screenWidth,
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
                        const SizedBox(height: 26),
                        Text(
                          'Have you known these 5 words?',
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
                              return EnglishCard();
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 20,
                            ),
                            itemCount: 5,
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
