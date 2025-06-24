import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/user_word_list.dart';

import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/learning_category_repository.dart';
import 'package:englens/src/data/repositories/user_words_repository.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:englens/src/ui/screens/study/random_flashcards/card_deck_preparation/card_deck_preparation_screen.dart';
import 'package:englens/src/ui/screens/study/random_flashcards/card_deck_preparation/card_deck_preparation_screen_viewmodel.dart';

import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen.dart';
import 'package:englens/src/ui/widget/my_wordlists/word_list/word_list_screen_viewmodel.dart';
import 'package:englens/src/utils/helper.dart';
import 'package:get/get.dart';

class RandomFlashcardsScreenArgs {}

class RandomFlashcardsScreenViewModel extends GetViewModelBase {
  final UserWordsRepositoryImpl _userWordsRepository =
      UserWordsRepositoryImpl();
  List<UserWordList> userWordList = [];
  List<Word> words = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  void initData() async {
    words = await LocalWordService.getAllWordsFromLocal();
    userWordList = await _userWordsRepository.getAllUserWordList();
    update();
  }

  void onTapCardDeckPreparation() {
    Get.toNamed(CardDeckPreparationScreen.routeName);
  }

  void onTapToFlashcard() {
    Get.toNamed(FlashcardsScreen.routeName);
  }

  void _onToWordList(String wordListId, String title) async {
    // List<Word> wordList =
    //     await _userWordsRepository.getAllUsersWords(wordListId: wordListId);
    var res = await Get.toNamed(
      WordListScreen.routeName,
      arguments: WordListScreenArgs(
        wordListId: wordListId,
        title: title,
        fromScreen: ToWordListFromScreen.randomFlashCard,
      ),
    );

    print(res);

    if (res != null && res is List<Word>) {
      Get.toNamed(
        CardDeckPreparationScreen.routeName,
        arguments: CardDeckPreparationScreenArgs(words: res),
      );
    }
  }

  void onTapToWordList() async {
    // Get.toNamed(MyWordlistsScreen.routeName);
    var res = await onTapShowUsersWordListBottomSheet(context: context!);
    if (res != null && res is String) {
      var uWordList =
          userWordList.where((element) => element.id == res).toList();
      _onToWordList(uWordList[0].id!, uWordList[0].name);
    }
  }
}
