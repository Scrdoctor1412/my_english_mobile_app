import 'package:dotted_border/dotted_border.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_daily_words_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LeitnerDailyWordsScreen extends StatelessWidget {
  static const routeName = '/leitnerDailyWordsScreen';
  const LeitnerDailyWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeitnerDailyWordsScreenViewModel>(
      init: LeitnerDailyWordsScreenViewModel(),
      builder: (controller) {
        _leitnerItemRow(
          int index, {
          IconData? icon,
          String? title,
          Color? color,
          int? wordsCount,
          int? stepperIndex,
          Widget? stepperItem,
          Function()? onTap,
        }) {
          __iconItem() {
            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: color ?? ThemePrimary.primaryOrange,
              ),
              child: Center(
                child: stepperItem ??
                    Icon(
                      icon ?? Icons.hourglass_empty,
                      color: Colors.white,
                    ),
              ),
            );
          }

          __dataItem() {
            return InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? "Waiting list",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.menu_book,
                              color: color ?? ThemePrimary.primaryOrange,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              '${wordsCount ?? 0} words',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            );
          }

          return Row(
            children: [
              __iconItem(),
              const SizedBox(width: 22),
              Expanded(child: __dataItem()),
            ],
          );
        }

        _body() {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                toolbarHeight: 45,
                floating: true,
                scrolledUnderElevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.arrow_back),
                            ),
                            const SizedBox(
                              width: 22,
                            ),
                            Text(
                              'Leitner',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                controller.onTapSettings();
                              },
                              icon: Icon(Icons.settings),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Column(children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          width: 145,
                                          height: 145,
                                          child: CircularProgressIndicator(
                                            value: 1,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          onTap: () {
                                            // print('tap');
                                            controller.onTapLearnNow();
                                          },
                                          child: Container(
                                            width: 160,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              // color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(70),
                                            ),
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(80),
                                              strokeWidth: 6,
                                              dashPattern: [8, 6],
                                              padding: EdgeInsets.all(12),
                                              color: ThemePrimary.primaryOrange,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Start',
                                                      style: TextStyle(
                                                        fontSize: 26,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Click to start',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                child: Column(
                                  children: [
                                    //Waiting block widget
                                    Row(
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                          child: Icon(
                                            Icons.hourglass_empty,
                                            color: ThemePrimary.primaryOrange,
                                            size: 32,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Waiting",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${controller.countWaitingWords}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Learning block widget
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                          child: Icon(
                                            Icons.collections_bookmark_sharp,
                                            color: ThemePrimary.primaryBlue,
                                            size: 26,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Learning",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${controller.countLearningWords}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Learned block widget
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                          child: Icon(
                                            Icons.school,
                                            color: ThemePrimary.grey,
                                            size: 29,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Learned",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${controller.countLearnedWords}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                expandedHeight: 55,
                toolbarHeight: 55,
                pinned: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffebeeff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Leitner Boxes',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text("in 19 days"),
                      ],
                    ),
                  ),
                ),
              ),

              DecoratedSliver(
                decoration: BoxDecoration(
                  color: Color(0xffebeeff),
                ),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      // vertical: 12,
                    ),
                    child: _leitnerItemRow(
                      index,
                      stepperIndex: index,
                      title: controller.leitnerItems[index].title,
                      color: controller.leitnerItems[index].color,
                      stepperItem: controller.leitnerItems[index].stepperItem,
                      icon: controller.leitnerItems[index].icon,
                      onTap: controller.leitnerItems[index].onTap,
                      wordsCount:
                          controller.leitnerItems[index].wordList!.length,
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 22,
                  ),
                  itemCount: controller.leitnerItems.length,
                ),
              ),
              // SliverFillRemaining(),
            ],
          );
        }

        return SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: _body(),
          ),
        );
      },
    );
  }
}
