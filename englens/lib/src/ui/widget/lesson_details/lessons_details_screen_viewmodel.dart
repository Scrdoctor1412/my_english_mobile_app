import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:get/get.dart';

class LessonDetailsScreenViewmodelArgs {
  final List<Lesson> lessons;
  final String lessonImage;
  final String topicTitle;

  LessonDetailsScreenViewmodelArgs({
    required this.lessons,
    required this.lessonImage,
    required this.topicTitle,
  });
}

class LessonsDetailsScreenViewmodel extends GetViewModelBase {
  List<Lesson> lessons = [];
  String lessonImage = '';
  String topicTitle = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      LessonDetailsScreenViewmodelArgs args = Get.arguments;
      lessons = args.lessons;
      lessonImage = args.lessonImage;
      topicTitle = args.topicTitle;
    }
  }
}
