import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen.dart';
import 'package:englens/src/ui/screens/home/home_screen.dart';
import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen.dart';
import 'package:englens/src/ui/screens/settings/settings_screen.dart';
import 'package:englens/src/ui/screens/study/study_screen.dart';
import 'package:get/get.dart';

class TabsScreenViewArgs {
  final int? tabIndex;
  TabsScreenViewArgs({this.tabIndex});
}

class TabsScreenViewmodel extends GetViewModelBase {
  RxInt tabIndex = 0.obs;

  var tabsScreen = [
    HomeScreen(),
    StudyScreen(),
    // ScanToTranslateScreen(),
    EnglishHandbookScreen(),
    SettingsScreen(),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      TabsScreenViewArgs args = Get.arguments as TabsScreenViewArgs;
      tabIndex.value = args.tabIndex ?? 0;
    }
  }

  void onTapChangeScreen(int index) {
    tabIndex.value = index;
    update();
  }
}
