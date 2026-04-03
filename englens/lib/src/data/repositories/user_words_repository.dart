import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/core/service/firebase/auth/auth_service.dart';
import 'package:englens/src/core/service/firebase/word/word_service.dart';

import 'package:get/get.dart';

abstract interface class UserWordsRepository {
  Future<List<Word>> getAllUsersWords({required String wordListId});

  Future<bool> addWord({required Word word, required String wordListId});

  Future<bool> deleteWord({required String wordId, required String wordListId});

  Future<bool> updateWord({
    required String wordId,
    required String wordListId,
    required Word word,
  });

  Future<List<UserWordList>> getAllUserWordList();

  Future<bool> addWordList({required UserWordList userWordList});

  Future<bool> deleteWordList({required String wordListId});

  Future<bool> updateWordList({required UserWordList userWordList});
}

class UserWordsRepositoryImpl extends GetxController
    implements UserWordsRepository {
  final AuthService _authService = Get.find<AuthService>();
  final WordService _wordService = Get.find<WordService>();

  @override
  Future<bool> addWord({required Word word, required String wordListId}) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.addWord(
      userId: userId,
      word: word,
      wordListId: wordListId,
    );
    return res;
  }

  @override
  Future<List<Word>> getAllUsersWords({required String wordListId}) async {
    var userId = _authService.user.value!.uid;
    var res = await _wordService.getAllUserWords(
      userId: userId,
      wordListId: wordListId,
    );
    return res;
  }

  @override
  Future<bool> deleteWord({
    required String wordId,
    required String wordListId,
  }) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.deleteWord(
      userId: userId,
      wordId: wordId,
      wordListId: wordListId,
    );
    return res;
  }

  @override
  Future<List<UserWordList>> getAllUserWordList() async {
    var userId = _authService.user.value!.uid;
    var res = await _wordService.getAllUserWordList(userId: userId);
    return res;
  }

  @override
  Future<bool> addWordList({required UserWordList userWordList}) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.addWordList(userId: userId, wordList: userWordList);
    return res;
  }

  @override
  Future<bool> deleteWordList({required String wordListId}) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.deleteWordList(
      userId: userId,
      wordListId: wordListId,
    );
    return res;
  }

  @override
  Future<bool> updateWordList({required UserWordList userWordList}) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.updateWordList(
      userId: userId,
      wordList: userWordList,
    );
    return res;
  }

  @override
  Future<bool> updateWord({
    required String wordId,
    required String wordListId,
    required Word word,
  }) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.updateWord(
      userId: userId,
      word: word,
      wordListId: wordListId,
      wordId: wordId,
    );
    return res;
  }
}
