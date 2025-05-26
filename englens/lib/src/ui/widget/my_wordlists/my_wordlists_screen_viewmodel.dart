import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWordlistsScreenViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordsRepository =
      UserWordsRepositoryImpl();
  List<UserWordList> userWordList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() async {
    // var res = await _userWordsRepository.getAllUsersWords();
    // wordList = res;
    // ShowLoadingDialog.showLoadingDialog(
    //     context: Get.context!, loadingText: "loading");
    var res = await _userWordsRepository.getAllUserWordList();
    userWordList = res;
    update();
  }

  void onTapToWordList(String wordListId, String title) async {
    List<Word> wordList =
        await _userWordsRepository.getAllUsersWords(wordListId);
    Get.toNamed(WordListScreen.routeName,
        arguments: WordListScreenArgs(wordList: wordList, title: title));
  }

  void onTapAddWordList() async {
    var name = await showGetTextInputDialog(context: context!);
    if (name != "") {
      ShowLoadingDialog.showLoadingDialog(
          context: context!, loadingText: "Adding...");
      UserWordList userWordList = UserWordList(name: name, wordList: []);
      var res = await _userWordsRepository.addWordList(userWordList);
      if (res) {
        ShowLoadingDialog.hideLoadingDialog(context: context!);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: ThemePrimary.darkBlue,
            content: Text(
              'Save success!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        initData();
      } else {
        ShowLoadingDialog.hideLoadingDialog(context: context!);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: ThemePrimary.darkBlue,
            content: Text(
              'Save failed!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }
  }
}
