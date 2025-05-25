import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:englens/src/service/firebase/word/word_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract interface class UserWordsRepository {

  Future<List<Word>> getAllUsersWords();

  Future<bool> addWord(Word word);

  Future<bool> deleteWord(Word word);
}

class UserWordsRepositoryImpl extends GetxController implements UserWordsRepository {

  final AuthService _authService = Get.find<AuthService>();
  final WordService _wordService = Get.find<WordService>();

  @override
  Future<bool> addWord(Word word) {
      var userId = _authService.user.value!.uid;
      var res = _wordService.addWord(userId: userId, word: word);
      return res;
  }

  @override
  Future<List<Word>> getAllUsersWords() {
    var userId = _authService.user.value!.uid;
    var res = _wordService.getAllUserWords(userId: userId);
    return res;
  }
  
  @override
  Future<bool> deleteWord(Word word) {
    var userId = _authService.user.value!.uid;
    var res = _wordService.deleteWord(userId: userId, wordId: word.id!);
    return res;
  }

}