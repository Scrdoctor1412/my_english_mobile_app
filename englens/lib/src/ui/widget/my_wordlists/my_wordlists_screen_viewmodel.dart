import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen_viewmodel.dart';
import 'package:get/get.dart';

class MyWordlistsScreenViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordsRepository =
      UserWordsRepositoryImpl();
  List<Word> wordList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() async {
    var res = await _userWordsRepository.getAllUsersWords();
    wordList = res;
  }

  void onTapToWordList() {
    Get.toNamed(WordListScreen.routeName,
        arguments: WordListScreenArgs(wordList: wordList));
  }
}
