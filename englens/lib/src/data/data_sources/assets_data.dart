import 'package:englens/src/data/models/word.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract interface class AssetsData extends GetxController {
  Future<List<Word>> getOxfordWordsByLetter(String letter);
  Future<List<Word>> getAllOxfordWords();
}

class AssetsDataImpl extends GetxController implements AssetsData {
  @override
  Future<List<Word>> getOxfordWordsByLetter(String letter) async {
    final path = 'assets/json/oxford_words/$letter.json';
    final jsonString = await rootBundle.loadString(path);
    WordList data = WordList.fromJson(jsonString);
    // final List<dynamic> jsonList = json.decode(jsonString);
    // return jsonList.map((json) => Word.fromJson(json)).toList();
    return data.words;
  }

  @override
  Future<List<Word>> getAllOxfordWords() async {
    final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
    final List<Word> words = [];
    for (final letter in letters) {
      final List<Word> wordsByLetter = await getOxfordWordsByLetter(letter);
      words.addAll(wordsByLetter);
    }
    return words;
  }
}
