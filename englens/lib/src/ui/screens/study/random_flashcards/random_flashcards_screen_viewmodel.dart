import 'package:englens/src/core/base_view_model.dart';

import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/local_word_service.dart';

import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen.dart';
import 'package:get/get.dart';

class RandomFlashcardsScreenViewModel extends GetViewModelBase {
  List<Word> words = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() async {
    words = LocalWordService.getAllWordsFromLocal();
    print(words.length);
    update();
  }

  void onTapToFlashcard() {
    Get.toNamed(FlashcardsScreen.routeName);
  }

  void onTapToWordList() {
    Get.toNamed(MyWordlistsScreen.routeName);
  }
}
