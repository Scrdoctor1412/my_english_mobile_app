import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen.dart';
import 'package:get/get.dart';

class StudyScreenViewmodel extends GetViewModelBase {
  void onTapToMyWordList() {
    Get.toNamed(MyWordlistsScreen.routeName);
  }
}
