import 'package:auto_size_text/auto_size_text.dart';
import 'package:englens/src/theme/theme_primary.dart';
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

        _lessonItem(int index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
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
                ),
                const Spacer(),
                Expanded(
                  flex: 1,
                  child: Container(
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
                ),
              ],
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                        tag: 'to_lesson_${controller.topicTitle}',
                        child: Image.asset(controller.lessonImage),
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
                                Get.toNamed(
                                  WordDetailsScreen.routeName,
                                  arguments: WordDetailsScreenViewmodelArgs(
                                      words:
                                          controller.lessons[index].wordList!,
                                      lessonTitle:
                                          controller.lessons[index].title,
                                      isFromLessonDetailsScreen: true),
                                );
                              },
                              child: _lessonItem(index),
                            ),
                            Divider(
                              color: ThemePrimary.grey.withAlpha(60),
                              height: 30,
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
