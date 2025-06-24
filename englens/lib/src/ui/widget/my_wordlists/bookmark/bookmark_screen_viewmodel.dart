import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:englens/src/ui/widget/lesson_details/lesson_details_screen.dart';
import 'package:englens/src/ui/widget/lesson_details/lessons_details_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreenViewmodel extends GetViewModelBase {
  List<Lesson> bookmarkedLessons = [];
  List<LearningCategory> bookmarkedBooks = [];
  List<String> bookmarkedLessonTopicTitle = [];

  late SharedPreferences prefs;

  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  LearningCategory _getTopic(String topicId) {
    var list = LocalWordService.getAllLearningCategory();
    var res = list.where((element) => element.id == topicId).toList();
    return res[0];
  }

  dynamic _getLesson(String lessonId) {
    var list = LocalWordService.getAllLearningCategory();
    for (var item in list) {
      for (var lesson in item.lessons!) {
        if (lesson.id == lessonId) {
          var res = lesson;
          return res;
        }
      }
    }
    //)
    return null;
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();

    List<String>? item1 = prefs.getStringList("bookmarkbooks");
    List<String>? item2 = prefs.getStringList("bookmarlessons");
    List<String>? item2TopicId = prefs.getStringList("bookmarlessonstopicid");

    print(item1);
    print(item2);

    if (item1 != null) {
      for (var id in item1) {
        var item = _getTopic(id);
        bookmarkedBooks.add(item);
      }
    }

    if (item2 != null) {
      for (var id in item2) {
        var item = _getLesson(id);
        if (item != null) {
          bookmarkedLessons.add(item);
        }
      }
    }

    if (item2TopicId != null) {
      for (var id in item2TopicId) {
        var item = _getTopic(id);
        if (item != null) {
          bookmarkedLessonTopicTitle.add(snakeCaseToNormal(item.title));
        }
      }
    }
    isLoading = false;
    update();
  }

  void onTapGetToLessonDetails(int index) {
    Get.toNamed(
      LessonDetailsScreen.routeName,
      arguments: LessonDetailsScreenViewmodelArgs(
        lessons: bookmarkedBooks[index].lessons!,
        lessonImage:
            'assets/images/learning_category/${bookmarkedBooks[index].title}.jpg',
        topicTitle: snakeCaseToNormal(bookmarkedBooks[index].title),
        topicId: bookmarkedBooks[index].id,
      ),
    );
  }

  void onTapDeleteBookmarkBook(int index) {
    List<String>? item1 = prefs.getStringList("bookmarkbooks");
    item1!.removeAt(index);
    prefs.setStringList("bookmarkbooks", item1);
    bookmarkedBooks.removeAt(index);
    update();
  }

  void onTapDeleteBookmarkLesson(int index) {
    List<String>? item2 = prefs.getStringList("bookmarlessons");
    List<String>? item2TopicId = prefs.getStringList("bookmarlessonstopicid");

    var topic = _getTopic(item2TopicId![index]);
    topic.lessons![index].isBookmarked = !topic.lessons![index].isBookmarked!;
    LocalWordService.updateCategory(topic);

    bookmarkedLessons.removeAt(index);
    item2!.removeAt(index);
    item2TopicId.removeAt(index);
    prefs.setStringList("bookmarlessons", item2);

    update();
  }
}
