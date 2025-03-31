import 'package:englens/src/ui/screens/study/study_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyScreen extends StatelessWidget {
  static const routeName = '/studyScreen';
  const StudyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyScreenViewmodel>(
      init: StudyScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        _body() {
          return Center(
            child: Text('Study screen'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
