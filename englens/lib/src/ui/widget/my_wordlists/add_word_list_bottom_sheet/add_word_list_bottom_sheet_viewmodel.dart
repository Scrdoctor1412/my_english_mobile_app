import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/user_word_list.dart';

import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';

class AddWordListBottomSheetViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordsRepository =
      UserWordsRepositoryImpl();
  List<UserWordList> wordLists = [];
  bool isLoading = true;
  @override
  void onInit() async {
    // TODO: implement onInit

    // initData();
    super.onInit();
    initData();
  }

  void onTapAddWordList() async {
    var name = await showGetTextInputDialog(context: context!);
    if (name != "") {
      ShowLoadingDialog.showLoadingDialog(
          context: context!, loadingText: "Adding...");
      UserWordList userWordList = UserWordList(name: name, wordList: []);
      var res =
          await _userWordsRepository.addWordList(userWordList: userWordList);
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
        // wordLists = await _userWordsRepository.getAllUserWordList();
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

  void initData() async {
    wordLists = await _userWordsRepository.getAllUserWordList();
    isLoading = false;
    update();
  }
}
