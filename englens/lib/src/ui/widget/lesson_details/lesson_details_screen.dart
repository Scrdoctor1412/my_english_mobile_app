import 'package:auto_size_text/auto_size_text.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class LessonDetailsScreen extends StatelessWidget {
  static const String routeName = '/lessonDetailsScreen';
  const LessonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonsDetailsScreenViewmodel>(
      init: LessonsDetailsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;
        _appBar() {
          return AppBar(
            // title: Text("Lesson Details"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.close),
              color: Colors.black,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.bookmark_add_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Perform search action
                },
              ),
            ],
          );
        }

        // Widget _

        _LessonLearnFlow(int index) {
          __lessonLearnItem(
              {required String title,
              required String assetImagePath,
              required VoidCallback onTap}) {
            return GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemePrimary.primaryBlue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(42),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          assetImagePath,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(title),
                ],
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            child: Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 2,
                  color: ThemePrimary.grey,
                )),
                __lessonLearnItem(
                  title: 'Review',
                  assetImagePath: 'assets/icons/review_blue.png',
                  onTap: () {
                    Get.toNamed(
                      WordDetailsScreen.routeName,
                      arguments: WordDetailsScreenViewmodelArgs(
                          words: controller.lessons[index].wordList!,
                          lessonTitle: controller.lessons[index].title,
                          isFromLessonDetailsScreen: true),
                    );
                  },
                ),
                Expanded(
                    child: Divider(
                  thickness: 2,
                  color: ThemePrimary.grey,
                )),
                __lessonLearnItem(
                  title: 'Flashcards',
                  assetImagePath: 'assets/icons/flashcards_blue.png',
                  onTap: () {
                    Get.toNamed(
                      FlashcardsScreen.routeName,
                      arguments: FlashcardsScreenArgs(
                        title: controller.lessons[index].title,
                        wordList: controller.lessons[index].wordList!,
                      ),
                    );
                  },
                ),
                Expanded(
                    child: Divider(
                  thickness: 2,
                  color: ThemePrimary.grey,
                )),
              ],
            ),
          );
        }

        _lessonItem2(int index) {
          return Container(
            width: screenWidth,
            // height: screenHeight,
            child: ExpansionTileTheme(
              data: ExpansionTileThemeData(
                collapsedBackgroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                collapsedShape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                collapsedIconColor: Colors.black,
                iconColor: Colors.black,
                collapsedTextColor: Colors.black,
              ),
              child: ExpansionTile(
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // controller.lessons[0].title,
                        'Lesson ${index + 1}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AutoSizeText(
                        // '${controller.lessons[0].wordList?.length} words',
                        controller.lessons[index].title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: screenWidth * 0.2,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bookmark_add_outlined),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.chevron_right),
                      // ),
                      Icon(
                        Icons.chevron_right,
                        // color: ThemePrimary.grey,
                      ),
                    ],
                  ),
                ),
                children: [
                  _LessonLearnFlow(index),
                ],
              ),
            ),
          );
        }

        _body() {
          return Container(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    // top: 12,
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      // width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: 'to_lesson_${controller.topicTitle}',
                          child: Image.asset(controller.lessonImage),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      controller.topicTitle,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Words Related to ${controller.topicTitle}',
                      style: TextStyle(fontSize: 19, color: ThemePrimary.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 26),
                    Column(
                      children: List.generate(
                        controller.lessons.length,
                        (index) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Get.toNamed(
                                //   WordDetailsScreen.routeName,
                                //   arguments: WordDetailsScreenViewmodelArgs(
                                //       words:
                                //           controller.lessons[index].wordList!,
                                //       lessonTitle:
                                //           controller.lessons[index].title,
                                //       isFromLessonDetailsScreen: true),
                                // );
                              },
                              child: _lessonItem2(index),
                            ),
                            Divider(
                              color: ThemePrimary.grey.withAlpha(60),
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
