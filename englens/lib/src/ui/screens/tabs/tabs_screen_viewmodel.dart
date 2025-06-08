import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen.dart';
import 'package:englens/src/ui/screens/home/home_screen.dart';
import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen.dart';
import 'package:englens/src/ui/screens/settings/settings_screen.dart';
import 'package:englens/src/ui/screens/study/study_screen.dart';

class TabsScreenViewmodel extends GetViewModelBase {
  int tabIndex = 0;

  var tabsScreen = [
    HomeScreen(),
    StudyScreen(),
    // ScanToTranslateScreen(),
    EnglishHandbookScreen(),
    SettingsScreen(),
  ];

  void onTapChangeScreen(int index) {
    tabIndex = index;
    update();
  }
}
