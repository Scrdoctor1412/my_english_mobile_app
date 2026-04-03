import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/ui/widget/my_wordlists/bookmark/bookmark_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen_viewmodel.dart';
import 'package:englens/src/core/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWordlistsScreenViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordsRepository =
      UserWordsRepositoryImpl();
  List<UserWordList> userWordList = [];
  bool isLoading = true;

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
    isLoading = false;
    update();
  }

  void onTapToWordList(String wordListId, String title) async {
    // List<Word> wordList =
    //     await _userWordsRepository.getAllUsersWords(wordListId: wordListId);
    Get.toNamed(
      WordListScreen.routeName,
      arguments: WordListScreenArgs(wordListId: wordListId, title: title),
    );
  }

  void onTapToBookmark() {
    Get.toNamed(BookmarkScreen.routeName);
  }

  void onTapAddWordList() async {
    var name = await showGetTextInputDialog(context: context!);
    if (name != "") {
      ShowLoadingDialog.showLoadingDialog(
        context: context!,
        loadingText: "Adding...",
      );
      UserWordList userWordList = UserWordList(name: name, wordList: []);
      var res = await _userWordsRepository.addWordList(
        userWordList: userWordList,
      );
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

  void onTapUpdateWordList(int index) async {
    var name = await showGetTextInputDialog(context: context!);
    if (name != "") {
      ShowLoadingDialog.showLoadingDialog(
        context: context!,
        loadingText: "Adding...",
      );
      // UserWordList userWordList = UserWordList(name: name, wordList: []);
      var userWord = userWordList[index].copyWith(name: name);
      var res = await _userWordsRepository.updateWordList(
        userWordList: userWord,
      );
      if (res) {
        ShowLoadingDialog.hideLoadingDialog(context: context!);
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: ThemePrimary.darkBlue,
            content: Text(
              'Update success!',
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
              'Update failed!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  void onTapDeleteWordList(String wordListId) async {
    await showCustomAlertDialog(
      title: "Alert",
      content:
          "Do you want to delete this word list? All of it\'s content will be deleted.",
      context: context!,
      onAccept: () async {
        Get.back();
        ShowLoadingDialog.showLoadingDialog(
          context: context!,
          loadingText: "Deleting...",
        );
        // var res = await _userWordsRepository.deleteWordList(wordListId);
        try {
          var res = await _userWordsRepository.deleteWordList(
            wordListId: wordListId,
          );
          if (res) {
            ShowLoadingDialog.hideLoadingDialog(context: context!);
            ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 500),
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
                duration: Duration(milliseconds: 500),
                backgroundColor: ThemePrimary.darkBlue,
                content: Text(
                  'Delete failed!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        } catch (e) {
          debugPrint(e.toString());
          ShowLoadingDialog.hideLoadingDialog(context: context!);
        }
      },
    );
  }
}
