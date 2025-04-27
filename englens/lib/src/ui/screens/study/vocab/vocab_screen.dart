import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/vocab/vocab_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/lesson_details/lesson_details_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class VocabScreen extends StatelessWidget {
  static const routeName = '/vocabScreen';
  const VocabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VocabScreenViewmodel>(
      init: VocabScreenViewmodel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text('Vocabulary'),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('0 lessons'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 120,
                      child:
                          Image.asset('assets/images/study/pronunciation.png'),
                    ),
                  ],
                )
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
                    Get.toNamed(controller.vocabularySectionScreenName[index]);
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
      },
    );
  }
}
