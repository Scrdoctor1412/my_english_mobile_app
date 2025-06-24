import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englens/src/data/models/user_word_list.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class WordService extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // final AuthService authService = Get.find<AuthService>();
  var uuid = Uuid();

  //---------WORD LIST--------

  Future<List<UserWordList>> getAllUserWordList(
      {required String userId}) async {
    List<UserWordList> list = [];
    try {
      QuerySnapshot res = await _fireStore
          .collection("users")
          .doc(userId)
          .collection('wordlist')
          .get();
      for (var docSnapShot in res.docs) {
        var data = docSnapShot.data();
        if (data != null && data is Map<String, dynamic>) {
          var userWordList = UserWordList.fromMap(data);
          list.add(userWordList);
        }
      }
      return list;
    } catch (e) {
      debugPrint(e.toString());
      return list;
    }
  }

  Future<bool> addWordList(
      {required String userId, required UserWordList wordList}) async {
    bool isSuccess = false;
    try {
      //check duplicate
      var wordLists = await getAllUserWordList(userId: userId);
      for (var item in wordLists) {
        if (item.name == wordList.name) {
          return isSuccess;
        }
      }

      var id = uuid.v4();
      wordList.id = id;

      await _fireStore
          .collection("users")
          .doc(userId)
          .collection("wordlist")
          .doc(id)
          .set(wordList.toMap())
          .then(
        (value) {
          isSuccess = true;
        },
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return isSuccess;
    }
  }

  Future<bool> deleteWordList(
      {required String userId, required String wordListId}) async {
    bool isSuccess = false;
    try {
      var words = await getAllUserWords(userId: userId, wordListId: wordListId);
      for (var item in words) {
        deleteWord(userId: userId, wordListId: wordListId, wordId: item.id!);
      }
      await _fireStore
          .collection("users")
          .doc(userId)
          .collection("wordlist")
          .doc(wordListId)
          .delete()
          .then(
        (value) {
          isSuccess = true;
        },
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return isSuccess;
    }
  }

  Future<bool> updateWordList(
      {required String userId, required UserWordList wordList}) async {
    bool isSuccess = false;
    try {
      await _fireStore
          .collection("users")
          .doc(userId)
          .collection("wordlist")
          .doc(wordList.id)
          .update(wordList.toMap())
          .then((value) {
        isSuccess = true;
      });
      return isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      return isSuccess;
    }
  }

  //----------WORD-----------

  Future<List<Word>> getAllUserWords(
      {required String userId, required String wordListId}) async {
    List<Word> words = [];
    try {
      QuerySnapshot res = await _fireStore
          .collection('users')
          .doc(userId)
          .collection('wordlist')
          .doc(wordListId)
          .collection('words')
          .get();

      for (var docSnapShot in res.docs) {
        var data = docSnapShot.data();
        if (data != null && data is Map<String, dynamic>) {
          var word = Word.fromJson(data);
          words.add(word);
        }
      }
      return words;
    } catch (e) {
      print(e);
      return words;
    }
  }

  Future<bool> addWord(
      {required String userId,
      required Word word,
      required String wordListId}) async {
    bool isSuccess = false;
    try {
      //check duplicate
      var words = await getAllUserWords(userId: userId, wordListId: wordListId);
      for (var item in words) {
        if (word.word == item.word) {
          return isSuccess;
        }
      }

      // var id = uuid.v4();
      // word.id = id;
      var jsonWord = word.toMap();

      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('wordlist')
          .doc(wordListId)
          .collection('words')
          .doc(word.id)
          .set(jsonWord)
          .then(
        (value) {
          isSuccess = true;
        },
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return isSuccess;
    }
  }

  Future<bool> deleteWord(
      {required String userId,
      required String wordListId,
      required String wordId}) async {
    bool isSuccess = false;
    try {
      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('wordlist')
          .doc(wordListId)
          .collection('words')
          .doc(wordId)
          .delete()
          .then(
        (value) {
          isSuccess = true;
        },
      );
      return isSuccess;
    } catch (e) {
      print(e);
      return isSuccess;
    }
  }

  Future<bool> updateWord(
      {required String userId,
      required Word word,
      required String wordListId,
      required String wordId}) async {
    bool isSuccess = false;
    try {
      await _fireStore
          .collection('users')
          .doc(userId)
          .collection("wordlist")
          .doc(wordListId)
          .collection("words")
          .doc(wordId)
          .update(word.toMap())
          .then(
        (value) {
          isSuccess = true;
        },
      );
      return isSuccess;
    } catch (e) {
      debugPrint(e.toString());
      return isSuccess;
    }
  }
}
