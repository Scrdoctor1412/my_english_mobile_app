import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_edit_screen/word_list_edit_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_edit_screen/word_list_edit_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class WordListScreenArgs {
  final String title;
  final String wordListId;
  WordListScreenArgs({required this.wordListId, required this.title});
}

class WordListScreenViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordsRepository =
      UserWordsRepositoryImpl();
  late String title;
  late String wordListId;
  List<Word> wordList = [];

  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      WordListScreenArgs args = Get.arguments as WordListScreenArgs;
      wordListId = args.wordListId;
      title = args.title;
    }
    initData();
  }

  void initData() async {
    var res =
        await _userWordsRepository.getAllUsersWords(wordListId: wordListId);
    wordList = res;
    isLoading = false;
    update();
  }

  void onTapToWordDetails(Word word) {
    Get.toNamed(
      WordDetailsScreen.routeName,
      arguments: WordDetailsScreenViewmodelArgs(
        onlyWord: [word],
      ),
    );
  }

  void onTapEditWord(int index) {
    Get.toNamed(
      WordListEditScreen.routeName,
      arguments: WordListEditScreenArgs(
        word: wordList[index],
      ),
    );
  }

  void onTapCreateWord() {}

  void onTapDeleteWord(int index) async {
    await showCustomAlertDialog(
      context: context!,
      title: "Alert",
      content: "Do you want to delete this word?",
      onAccept: () async {
        Get.back();
        ShowLoadingDialog.showLoadingDialog(
            context: context!, loadingText: "Deleting...");
        var res = await _userWordsRepository.deleteWord(
            wordId: wordList[index].id!, wordListId: wordListId);
        if (res) {
          ShowLoadingDialog.hideLoadingDialog(context: context!);
          ScaffoldMessenger.of(context!).showSnackBar(
            SnackBar(
              backgroundColor: ThemePrimary.darkBlue,
              content: Text(
                'Delete success!',
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
                'Delete failed!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
