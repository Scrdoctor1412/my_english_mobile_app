import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class WordListScreenArgs {
  final List<Word> wordList;
  WordListScreenArgs({required this.wordList});
}

class WordListScreenViewmodel extends GetViewModelBase {
  late List<Word> wordList;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      WordListScreenArgs args = Get.arguments as WordListScreenArgs;
      wordList = args.wordList;
    }
  }
}
