import 'package:englens/src/ui/screens/study/grammar/grammar_lessons/grammar_lessons_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrammarLessonsScreen extends GetView<GrammarLessonsScreenViewmodel> {
  static const routeName = "/grammarLessonsScreen";
  const GrammarLessonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar() {
      return AppBar(title: Text(controller.title));
    }

    _grammarLessonsRowItem({
      required int index,
      required String title,
      required String subtitle,
    }) {
      return InkWell(
        onTap: () {
          controller.onTapToGrammarLessonDetails(index);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(subtitle, style: TextStyle(fontSize: 16), maxLines: 3),
                  ],
                ),
              ),
              // const Spacer(),
              Checkbox(
                value: controller.listMdPropsCheckValue[index],
                onChanged: (value) {
                  controller.onTapCheckLessons(value!, index);
                },
              ),
            ],
          ),
        ),
      );
    }

    _body() {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
            child: _grammarLessonsRowItem(
              index: index,
              title: controller.listMdProps[index].title!,
              subtitle: controller.listMdProps[index].subTitle!,
            ),
          );
        },
        itemCount: controller.listMdProps.length,
      );
    }

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
