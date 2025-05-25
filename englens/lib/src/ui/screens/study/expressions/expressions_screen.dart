import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/expressions/expressions_screen_viewmode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpressionsScreen extends StatelessWidget {
  static const routeName = '/expressionsScreen';
  const ExpressionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpressionsScreenViewModel>(
      init: ExpressionsScreenViewModel(),
      builder: (controller) {
        controller.context = context;
        _appBar() {
          return AppBar(
            title: Text('Expressions'),
            backgroundColor: ThemePrimary.primaryOrange,
          );
        }

        _expressionsItem(int index) {
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
                  controller.expressionsSection[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                    '${controller.expressionsSectionTopicsCount[index]} topics'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 120,
                      child: Image.asset('assets/images/study/expressions.png'),
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
                  child: _expressionsItem(index),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemCount: controller.expressionsSection.length,
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
