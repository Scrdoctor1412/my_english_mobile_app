import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/study/vocab/vocab_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/lesson_details/lesson_details_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningCategoryScreen extends GetView<LearningCategoryScreenViewModel> {
  static const routeName = '/learningCatScreen';
  const LearningCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar() {
      return AppBar(
        title: Text(controller.title),
        backgroundColor:
            controller.screenType == LearningCategoryScreenType.expressions
            ? ThemePrimary.primaryOrange
            : Colors.lightBlue,
      );
    }

    _vocabItem(int index) {
      return Container(
        decoration: BoxDecoration(
          // color: Color(0xfffbf1eb),
          color: Color(0xffe7f5f5),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.vocabularySection[index],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text('${controller.vocabSectionTopics[index]} topics'),
            // const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 120,
                  width: 80,
                  child:
                      controller.screenType ==
                          LearningCategoryScreenType.expressions
                      ? Image.asset('assets/images/study/expressions.png')
                      : Image.asset('assets/images/study/vocab.png'),
                ),
              ],
            ),
          ],
        ),
      );
    }

    _body() {
      // return _wordListByTopic();
      return ListView.separated(
        padding: EdgeInsets.only(top: 15),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              // vertical: 12,
            ),
            child: InkWell(
              onTap: () {
                // Get.toNamed(controller.vocabularySectionScreenName[index]);
                controller.onTapToCatLessons(index);
              },
              child: _vocabItem(index),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: controller.vocabularySection.length,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }
}
