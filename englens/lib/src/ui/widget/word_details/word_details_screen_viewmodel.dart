import 'package:englens/src/constants/app_constants.dart';
import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/service/firebase/word/word_service.dart';
import 'package:englens/src/service/leitner_box_service.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/complete/complete_screen.dart';
import 'package:englens/src/ui/widget/complete/complete_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/loading_dialog.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordDetailsScreenViewmodelArgs {
  final List<Word>? words;
  final String? lessonTitle;
  final List<Word>? onlyWord;
  final bool? isFromLessonDetailsScreen;

  WordDetailsScreenViewmodelArgs({
    this.words,
    this.lessonTitle,
    this.onlyWord,
    this.isFromLessonDetailsScreen,
  });
}

class WordDetailsScreenViewmodel extends GetViewModelBase {
  final UserWordsRepositoryImpl userWordsRepositoryImpl =
      UserWordsRepositoryImpl();
  late SharedPreferences prefs;

  List<Word> words = [];
  String lessonTitle = '';
  List<Word>? onlyWord;
  bool isFromLessonDetailsScreen = false;
  final player = AudioPlayer();
  late double progressValue;
  int pageCurrentIndex = 0;
  int pageLastIndex = 0;

  //list temp words use for creating space to swipe to complete screen after user's complete reviewing
  List<Word> tempWords = [];

  //List cờ mở - tắt leitner box
  List<bool> isAddToLeitner = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      WordDetailsScreenViewmodelArgs args = Get.arguments;
      words = args.words ?? [];
      lessonTitle = args.lessonTitle ?? "";
      isFromLessonDetailsScreen = args.isFromLessonDetailsScreen ?? false;
      onlyWord = args.onlyWord ?? null;
    }

    //Gán cờ - có thêm vào leitner box hay chưa
    if (words.isNotEmpty) {
      isAddToLeitner = List.generate(words.length, (index) => false);
    } else if (onlyWord != null && onlyWord!.isNotEmpty) {
      isAddToLeitner = List.generate(onlyWord!.length, (index) => false);
    }

    for (var word in words) {
      tempWords.add(word);
    }
    //dummy word
    tempWords.add(Word(
        word: "",
        pos: "",
        phonetic: "",
        phoneticText: "",
        phoneticAm: "",
        phoneticAmText: "",
        senses: [Sense(definition: "", examples: [])]));
    progressValue = 1 / words.length;

    initData();
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();

    //Lấy danh sách các từ đang được thêm vào leitner box
    var listPrefs = prefs.getStringList(AppConstants.leitnerBoxPrefsKey);

    //Trường hợp từ vựng được truyền từ các bài học
    if (words != null && words.isNotEmpty) {
      for (var word in words) {
        if (listPrefs != null && listPrefs.isNotEmpty) {
          if (listPrefs.contains(word.id)) {
            isAddToLeitner[words.indexOf(word)] = true;
          }
        }
      }
    } else if (onlyWord != null && onlyWord!.isNotEmpty) {
      //Trường hợp từ vựng được truyền từ screen Home
      for (var word in onlyWord!) {
        if (listPrefs != null && listPrefs.isNotEmpty) {
          if (listPrefs.contains(word.id)) {
            isAddToLeitner[onlyWord!.indexOf(word)] = true;
          }
        }
      }
    }
    print(isAddToLeitner);
    update();
  }

  void onChangePage(int index) {
    if (index > words.length - 1) {
      onToCompleteScreen();
    }
    pageLastIndex = pageCurrentIndex;
    pageCurrentIndex = index;
    if (pageCurrentIndex > pageLastIndex) {
      progressValue += 1 / words.length;
    } else if (pageCurrentIndex < pageLastIndex) {
      progressValue -= 1 / words.length;
    }

    update();
  }

  void onToCompleteScreen() {
    Get.offNamed(
      CompleteScreen.routeName,
      arguments: CompleteScreenArgs(
        title: lessonTitle,
        flashcardArgs: FlashcardsScreenArgs(
          title: lessonTitle,
          wordList: words,
        ),
        type: CompleteScreenType.wordReview,
      ),
    );
  }

  void onTapPlayAudio(String audioUrl) async {
    try {
      await player.setUrl(audioUrl);
      player.play();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTapToggleWordToLeitnerBox(int index) async {
    isAddToLeitner[index] = !isAddToLeitner[index];

    //True - trường hợp thêm vào box
    if (isAddToLeitner[index]) {
      if (words != null && words.isNotEmpty) {
        LeitnerBoxService.addNewToLeitnerBox(words[index].id!);
        List<String> leitnerboxeswordsid =
            prefs.getStringList(AppConstants.leitnerBoxPrefsKey) ?? [];

        //check trùng
        int isDuplicate = leitnerboxeswordsid
            .indexWhere((element) => element == words[index].id!);
        if (isDuplicate == -1) {
          leitnerboxeswordsid.add(words[index].id!);
        }

        await prefs.setStringList(
            AppConstants.leitnerBoxPrefsKey, leitnerboxeswordsid);
      } else if (onlyWord != null && onlyWord!.isNotEmpty) {
        LeitnerBoxService.addNewToLeitnerBox(onlyWord![0].id!);
        List<String> leitnerboxeswordsid =
            prefs.getStringList(AppConstants.leitnerBoxPrefsKey) ?? [];

        //check duplicate
        int isDuplicate = leitnerboxeswordsid
            .indexWhere((element) => element == onlyWord!.first.id!);
        if (isDuplicate == -1) {
          leitnerboxeswordsid.add(onlyWord!.first.id!);
        }

        await prefs.setStringList(
            AppConstants.leitnerBoxPrefsKey, leitnerboxeswordsid);
      }
    } else {
      //False - trường hợp xóa khỏi box
      var listPrefs = prefs.getStringList(AppConstants.leitnerBoxPrefsKey);
      if (listPrefs != null && listPrefs.isNotEmpty) {
        if (words != null && words.isNotEmpty) {
          listPrefs.removeWhere((element) => element == words[index].id);
        } else if (onlyWord != null && onlyWord!.isNotEmpty) {
          listPrefs.removeWhere((element) => element == onlyWord![0].id);
        }

        await prefs.setStringList(AppConstants.leitnerBoxPrefsKey, listPrefs);
      }
    }

    update();
  }

  void onTapSaveWordToMyWordList({required Word word}) async {
    var wordListId = await onTapShowUsersWordListBottomSheet(context: context!);
    if (wordListId != null && wordListId is String) {
      ShowLoadingDialog.showLoadingDialog(
          context: context!, loadingText: 'Adding...');
      var res = await userWordsRepositoryImpl.addWord(
          word: word, wordListId: wordListId);
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
