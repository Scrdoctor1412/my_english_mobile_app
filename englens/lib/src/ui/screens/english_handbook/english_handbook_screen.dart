import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/common/english_card.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen_viewmodel.dart';
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
                icon: Icon(Icons.more_vert),
              )
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: ClipRRect(
                // clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 45,
                  // decoration: BoxDecoration(
                  //   color: Colors.white.withOpacity(0.2), // Nền chung mờ
                  //   borderRadius: BorderRadius.circular(25),
                  // ),
                  child: TabBar(
                    controller: controller.tabController,
                    padding: EdgeInsets.zero,
                    onTap: (value) {
                      controller.onTapChangeTabBarIndex(value);
                    },
                    indicator: BoxDecoration(
                      color: Color(0xfff1f0f6),
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      // border: Border(
                      //   bottom: BorderSide(),
                      // ),
                      // borderRadius: BorderRadius.circular(32),
                    ),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: ThemePrimary.successGreen,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Word List Dictionary'),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Word by Categories'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        _wordListTab() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              // const SizedBox(
              //   height: 12,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 12,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 230,
                        child: InkWell(
                          onTap: () {
                            print(index);
                          },
                          child: EnglishCard(
                            word: controller.wordList.words[index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: controller.wordList.words.length,
                  ),
                ),
              )
            ],
          );
        }

        _wordListByCategoryTab() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Word list by category'),
              ),
            ],
          );
        }

        _body() {
          return TabBarView(
            controller: controller.tabController,
            children: [
              _wordListTab(),
              _wordListByCategoryTab(),
            ],
          );
        }

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
            key: controller.key,
            distance: 90,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              shape: const CircleBorder(),
              backgroundColor: ThemePrimary.successGreen,
              foregroundColor: Colors.white,
              child: Icon(Icons.menu),
            ),
            closeButtonBuilder: FloatingActionButtonBuilder(
              size: 56,
              builder: (BuildContext context, void Function()? onPressed,
                  Animation<double> progress) {
                return IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                );
              },
            ),
            children: [
              FloatingActionButton.small(
                backgroundColor: ThemePrimary.successGreen,
                shape: const CircleBorder(),
                heroTag: null,
                child: const Icon(Icons.article),
                onPressed: () {
                  const SnackBar snackBar = SnackBar(
                    content: Text("SnackBar"),
                  );
                  controller.scaffoldKey.currentState?.showSnackBar(snackBar);
                },
              ),
              FloatingActionButton.small(
                backgroundColor: ThemePrimary.successGreen,
                shape: const CircleBorder(),
                heroTag: null,
                child: const Icon(Icons.text_fields),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: ((context) => const NextPage())));
                },
              ),
            ],
          ),
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
