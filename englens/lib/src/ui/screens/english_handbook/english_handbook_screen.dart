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
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 50,
                  // decoration: BoxDecoration(
                  //   color: Colors.white.withOpacity(0.2), // Nền chung mờ
                  //   borderRadius: BorderRadius.circular(25),
                  // ),
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    onTap: (value) {
                      controller.onTapChangeTabBarIndex(value);
                    },
                    // isScrollable: true,
                    indicator: BoxDecoration(
                      color: Color(0xfff1f0f6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),

                    // indicatorPadding: EdgeInsets.only(left: 20),
                    // dividerColor: Color(0xfff1f0f6),
                    // dividerColor: ThemePrimary.successGreen,
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
            children: [
              // const SizedBox(
              //   height: 12,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    // vertical: 12,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 250,
                        child:
                            EnglishCard(word: controller.wordList.words[index]),
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
          return TabBarView(children: [
            _wordListTab(),
            _wordListByCategoryTab(),
          ]);
        }

        return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
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
          ),
        );
      },
    );
  }
}

// class TabClipper extends CustomClipper<Path> {
//   // final int countPage;
//   // final double offset;

//   // TabClipper({required this.countPage, required this.offset});

//   double heightDefault = 48.0;
//   double padding = 9.0;
//   double sizePlus = 15;

//   @override
//   Path getClip(Size size) {
//     double titleBoxWidth = size.width / countPage;
//     double position = offset / countPage; //countPage;
//     Path path = Path();
//     path.moveTo(0.0, heightDefault + padding);
//     // path.lineTo(0.0, heightDefault+padding);

//     //1
//     path.lineTo(position - 15 - sizePlus * 0.5, heightDefault + padding);
//     //2
//     path.quadraticBezierTo(
//         position - 1.5 + padding * 0.6 - sizePlus * 0.5,
//         heightDefault + 0.7 + padding,
//         position + padding * 0.5 - sizePlus * 0.5,
//         heightDefault - 15 + padding);
//     //3
//     path.lineTo(position + padding * 0.5 - sizePlus * 0.5, 15 + padding);
//     //4
//     path.quadraticBezierTo(
//         position + 2.5 + padding * 0.3 - sizePlus * 0.5,
//         2.5 + padding * 0.6,
//         position + 15.0 + padding - sizePlus * 0.5,
//         padding);
//     //4
//     path.lineTo(
//         position + titleBoxWidth - 15.0 - padding + sizePlus * 0.5, padding);
//     //3
//     path.quadraticBezierTo(
//         position + titleBoxWidth - 2.5 - padding * 0.3 + sizePlus * 0.5,
//         2.5 + padding * 0.6,
//         position + titleBoxWidth - padding * 0.5 + sizePlus * 0.5,
//         15.0 + padding);
//     //2
//     path.lineTo(position + titleBoxWidth - padding * 0.5 + sizePlus * 0.5,
//         heightDefault - 15 + padding);

//     //1
//     path.quadraticBezierTo(
//         position + titleBoxWidth + 1.5 - padding * 0.6 + sizePlus * 0.5,
//         heightDefault + 0.7 + padding,
//         position + titleBoxWidth + 15 + sizePlus * 0.5,
//         heightDefault + padding);

//     path.lineTo(size.width, heightDefault + padding);
//     path.lineTo(size.width, size.height + padding);
//     path.lineTo(0, size.height + padding);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

// class TabsPainter extends CustomPainter {
//   final TabController controller;

//   TabsPainter({
//     required this.controller,
//   }) : super(repaint: controller);

//   final List<double> widths = [89, 98, 111, 141, 108];

//   @override
//   void paint(Canvas canvas, Size size) {
//     final animation = controller.animation!;
//     final paint = Paint()..color = myColor;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 1.5;
//     final dx = sumUntil(animation.value);
//     final dx2 = sumUntil(animation.value + 1);
//     final path = Path()..moveTo(-15, 47);
//     path.relativeLineTo(dx, 0);
//     path.relativeLineTo(0, -23);
//     path.relativeLineTo(8, 0);
//     path.moveTo(dx2 - 27, 24);
//     path.relativeLineTo(8, 0);
//     path.relativeLineTo(0, 23);
//     path.lineTo(sumUntil(5) - 20, 47);
//     canvas.drawPath(path, paint);
//   }

//   double sumUntil(double animation) {
//     double distance = 0;
//     final index = animation.floor();
//     for (int i = 0; i < index; i++) {
//       distance += widths[i];
//     }
//     if (index < widths.length) {
//       final leftover = animation - index;
//       distance += leftover * widths[index];
//     }
//     return distance;
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
