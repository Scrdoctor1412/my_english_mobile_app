import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/core/service/local_word_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonDetailsScreenViewmodelArgs {
  final List<Lesson> lessons;
  final String lessonImage;
  final String topicTitle;
  final String topicId;

  LessonDetailsScreenViewmodelArgs({
    required this.lessons,
    required this.lessonImage,
    required this.topicTitle,
    required this.topicId,
  });
}

class LessonsDetailsScreenViewmodel extends GetViewModelBase {
  final _learningCategoryRepositoryImpl =
      Get.find<LearningCategoryRepositoryImpl>();
  List<Lesson> lessons = [];
  String lessonImage = '';
  String topicTitle = '';
  String topicId = "";
  late SharedPreferences prefs;

  bool isBookmarkBook = false;
  List<bool> isBookmarkLessons = [];

  late LearningCategory topic;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      LessonDetailsScreenViewmodelArgs args = Get.arguments;
      lessons = args.lessons;
      lessonImage = args.lessonImage;
      topicTitle = args.topicTitle;
      topicId = args.topicId;
    }
    isBookmarkLessons = lessons.map((e) => e.isBookmarked ?? false).toList();
    initData();
  }

  LearningCategory _getTopic() {
    var list = _learningCategoryRepositoryImpl.getAllLearningCategory();
    var res = list.where((element) => element.id == topicId).toList();
    return res[0];
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();
    topic = _getTopic();
    isBookmarkBook = topic.isBookmarked ?? false;

    // prefs.remove("bookmarlessons");
    // prefs.remove("bookmarlessonstopicid");
    // prefs.remove("bookmarkbooks");

    update();
  }

  void onTapToggleBookmarkBook() {
    isBookmarkBook = !isBookmarkBook;
    topic.isBookmarked = isBookmarkBook;
    LocalWordService.updateCategory(topic);

    List<String>? items = prefs.getStringList("bookmarkbooks");
    if (items == null) {
      items = [];
      items.add(topic.id);
    } else {
      if (isBookmarkBook) {
        bool isDuplicate = false;
        for (var item in items!) {
          if (item == topic.id) {
            isDuplicate = true;
            break;
          }
        }
        if (!isDuplicate) {
          items.add(topic.id);
        }
      } else {
        items.remove(topic.id);
      }
    }

    prefs.setStringList("bookmarkbooks", items);
    update();
  }

  void onTapBookmarkLesson(int index) {
    isBookmarkLessons[index] = !isBookmarkLessons[index];
    lessons[index].isBookmarked = isBookmarkLessons[index];
    topic.lessons![index].isBookmarked = isBookmarkLessons[index];
    LocalWordService.updateCategory(topic);

    List<String>? items = prefs.getStringList("bookmarlessons");
    List<String>? itemsTopicId = prefs.getStringList("bookmarlessonstopicid");
    if (items == null) {
      items = [];
      itemsTopicId = [];
      items.add(topic.lessons![index].id!);
      itemsTopicId.add(topic.id);
    } else {
      if (isBookmarkLessons[index]) {
        bool isDuplicate = false;
        for (var item in items!) {
          if (item == topic.id) {
            isDuplicate = true;
            break;
          }
        }
        if (!isDuplicate) {
          items.add(topic.lessons![index].id!);
          itemsTopicId!.add(topic.id);
        }
      } else {
        items.remove(topic.lessons![index].id!);
        itemsTopicId!.remove(topic.id);
      }
    }

    prefs.setStringList("bookmarlessons", items);
    prefs.setStringList("bookmarlessonstopicid", itemsTopicId!);
    update();
  }
}
