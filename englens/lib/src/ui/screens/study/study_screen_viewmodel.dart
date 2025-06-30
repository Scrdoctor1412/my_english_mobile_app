import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_screen.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen.dart';
import 'package:get/get.dart';

class StudyScreenViewmodel extends GetViewModelBase {
  void onTapToMyWordList() {
    Get.toNamed(MyWordlistsScreen.routeName);
  }

  void onTapToLearningCat(
      {required String title, required LearningCategoryScreenType screenType}) {
    Get.toNamed(
      LearningCategoryScreen.routeName,
      arguments: LearningCategoryScreenViewArgs(
        title: title,
        screenType: screenType,
      ),
    );
  }
}
