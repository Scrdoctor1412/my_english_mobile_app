import 'package:englens/src/ui/screens/study/grammar/grammar_lessons_details/grammar_lessons_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class GrammarLessonsDetailsScreen
    extends GetView<GrammarLessonsDetailsScreenViewmodel> {
  static const routeName = '/grammarLessonsDetailsScreen';
  const GrammarLessonsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar() {
      return AppBar(title: Text(controller.title ?? "Grammar"));
    }

    _body() {
      return Markdown(data: controller.assetsData ?? "");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }
}
