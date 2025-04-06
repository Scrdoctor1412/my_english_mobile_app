import 'dart:convert';
import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:englens/src/data/models/sense.dart';

part 'generated/word.g.dart';

@HiveType(typeId: HiveTypes.word)
class Word {
  @HiveField(0)
  String word;

  @HiveField(1)
  String pos;

  @HiveField(2)
  String phonetic;

  @HiveField(3)
  String phoneticText;

  @HiveField(4)
  String phoneticAm;

  @HiveField(5)
  String phoneticAmText;

  @HiveField(6)
  List<Sense> senses;

  @HiveField(7)
  int? index;

  Word(
      {required this.word,
      required this.pos,
      required this.phonetic,
      required this.phoneticText,
      required this.phoneticAm,
      required this.phoneticAmText,
      required this.senses,
      this.index = 0});

  // Chuyển từ JSON String sang WordEntry
  factory Word.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Word(
      word: json["word"],
      pos: json["pos"],
      phonetic: json["phonetic"],
      phoneticText: json["phonetic_text"],
      phoneticAm: json["phonetic_am"],
      phoneticAmText: json["phonetic_am_text"],
      senses: (json["senses"] as List).map((e) => Sense.fromMap(e)).toList(),
      index: json["index"],
    );
  }

  // Chuyển từ Object Dart sang Map
  Map<String, dynamic> toMap() {
    return {
      "word": word,
      "pos": pos,
      "phonetic": phonetic,
      "phonetic_text": phoneticText,
      "phonetic_am": phoneticAm,
      "phonetic_am_text": phoneticAmText,
      "senses": senses.map((e) => e.toMap()).toList(),
      "index": index,
    };
  }

  // Chuyển từ Object Dart sang JSON String
  String toJson() {
    return jsonEncode(toMap());
  }
}

class WordList {
  List<Word> words;

  WordList({required this.words});

  // Chuyển từ JSON String sang danh sách WordEntry
  factory WordList.fromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return WordList(
      words: jsonList.map((e) => Word.fromJson(jsonEncode(e))).toList(),
    );
  }

  // Chuyển danh sách WordEntry sang Map
  Map<String, dynamic> toMap() {
    return {
      "words": words.map((e) => e.toMap()).toList(),
    };
  }

  // Chuyển danh sách WordEntry sang JSON String
  String toJson() {
    return jsonEncode(toMap());
  }
}
