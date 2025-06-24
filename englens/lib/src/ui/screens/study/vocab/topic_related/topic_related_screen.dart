import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/vocab/topic_related/topic_related_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/lesson_details/lesson_details_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class TopicRelatedScreen extends StatelessWidget {
  static const routeName = '/topicRelatedScreen';
  const TopicRelatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicRelatedScreenViewmodel>(
      init: TopicRelatedScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text('Topic-related'),
            backgroundColor: ThemePrimary.lightBlue,
          );
        }

        _wordListByTopicItem(String title, int index) {
          var processedTitle = snakeCaseToNormal(title);

          return Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              right: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: 'to_lesson_$processedTitle',
                      child: Image.asset(
                        'assets/images/topics/$title.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          processedTitle,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: ThemePrimary.successGreen,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    '${controller.topicsList[index].lessons!.length} Lesson'),
                                const SizedBox(width: 12),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.library_books_outlined,
                                  color: ThemePrimary.successGreen,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    '${controller.countLessonWords(index)} Words'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        _wordListByTopic() {
          return Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            LessonDetailsScreen.routeName,
                            arguments: LessonDetailsScreenViewmodelArgs(
                              lessons: controller.topicsList[index].lessons!,
                              lessonImage:
                                  'assets/images/topics/${controller.topicsList[index].title}.jpg',
                              topicTitle: snakeCaseToNormal(
                                  controller.topicsList[index].title),
                              topicId: controller.topicsList[index].id,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: _wordListByTopicItem(
                              controller.topicsList[index].title, index),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: controller.topicsList.length,
                  ),
                ),
              ],
            ),
          );
        }

        _body() {
          return _wordListByTopic();
        }

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }
}
