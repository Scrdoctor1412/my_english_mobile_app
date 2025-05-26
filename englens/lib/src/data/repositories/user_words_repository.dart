import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:englens/src/service/firebase/word/word_service.dart';

import 'package:get/get.dart';

abstract interface class UserWordsRepository {
  Future<List<Word>> getAllUsersWords(String wordListId);

  Future<bool> addWord(Word word, String wordListId);

  Future<bool> deleteWord(Word word, String wordListId);

  Future<List<UserWordList>> getAllUserWordList();

  Future<bool> addWordList(UserWordList userWordList);
}

class UserWordsRepositoryImpl extends GetxController
    implements UserWordsRepository {
  final AuthService _authService = Get.find<AuthService>();
  final WordService _wordService = Get.find<WordService>();

  @override
  Future<bool> addWord(Word word, String wordListId) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.addWord(
        userId: userId, word: word, wordListId: wordListId);
    return res;
  }

  @override
  Future<List<Word>> getAllUsersWords(String wordListId) async {
    var userId = _authService.user.value!.uid;
    var res = await _wordService.getAllUserWords(
        userId: userId, wordListId: wordListId);
    return res;
  }

  @override
  Future<bool> deleteWord(Word word, String wordListId) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.deleteWord(
        userId: userId, wordId: word.id!, wordListId: wordListId);
    return res;
  }

  @override
  Future<List<UserWordList>> getAllUserWordList() async {
    var userId = _authService.user.value!.uid;
    var res = await _wordService.getAllUserWordList(userId: userId);
    return res;
  }

  @override
  Future<bool> addWordList(UserWordList userWordList) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.addWordList(userId: userId, wordList: userWordList);
    return res;
  }
}
