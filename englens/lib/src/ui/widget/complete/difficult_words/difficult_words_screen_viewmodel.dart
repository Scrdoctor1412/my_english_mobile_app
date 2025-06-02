// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DifficultWordsScreenArgs {
  final List<Word> listIncorrect;
  DifficultWordsScreenArgs({
    required this.listIncorrect,
  });
}

class DifficultWordsScreenViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordRepo = UserWordsRepositoryImpl();
  List<Word> wordList = [];
  late List<Word> listIncorrect;
  Map<String, int> listMapWordIncorrect = {};
  List<String> listMapWordIncorrectKeys = [];

  List<Word> easyWordList = [];
  List<Word> mediumWordList = [];
  List<Word> hardWordList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      DifficultWordsScreenArgs args = Get.arguments as DifficultWordsScreenArgs;
      listIncorrect = args.listIncorrect;
    }

    initData();
  }

  void initData() {
    for (var i = 0; i < listIncorrect.length; i++) {
      if (wordList.contains(listIncorrect[i])) {
        // continue;
      } else {
        wordList.add(listIncorrect[i]);
      }

      if (listMapWordIncorrect[listIncorrect[i].word] != null &&
          listMapWordIncorrect[listIncorrect[i].word] is int) {
        listMapWordIncorrect[listIncorrect[i].word] =
            listMapWordIncorrect[listIncorrect[i].word]! + 1;
      } else {
        listMapWordIncorrect[listIncorrect[i].word] = 1;
      }
    }

    listMapWordIncorrectKeys = listMapWordIncorrect.keys.toList();

    for (var word in wordList) {
      if (listMapWordIncorrect[word.word]! > 5) {
        hardWordList.add(word);
      } else if (listMapWordIncorrect[word.word]! > 2 &&
          listMapWordIncorrect[word.word]! <= 5) {
        mediumWordList.add(word);
      } else {
        easyWordList.add(word);
      }
    }
  }

  void onTapToWordDetails(Word word) {
    Get.toNamed(
      WordDetailsScreen.routeName,
      arguments: WordDetailsScreenViewmodelArgs(
        onlyWord: [word],
      ),
    );
  }

  void onTapSaveWordToMyWordList({required Word word}) async {
    var wordListId = await onTapShowUsersWordListBottomSheet(context: context!);
    if (wordListId != null && wordListId is String) {
      ShowLoadingDialog.showLoadingDialog(
          context: context!, loadingText: 'Adding...');
      var res = await _userWordRepo.addWord(word: word, wordListId: wordListId);
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
