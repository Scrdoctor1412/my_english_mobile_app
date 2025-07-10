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

  @HiveField(8)
  String? img;

  @HiveField(9)
  String? pronunciation;

  @HiveField(10)
  String? id;

  @HiveField(11)
  String? lastLearned;

  Word({
    required this.word,
    required this.pos,
    required this.phonetic,
    required this.phoneticText,
    required this.phoneticAm,
    required this.phoneticAmText,
    required this.senses,
    this.index = 0,
    this.img = "",
    this.pronunciation,
    this.id = "",
    this.lastLearned,
  });

  // Chuyển từ JSON String sang WordEntry
  factory Word.fromJson(Map<String, dynamic> json) {
    // Map<String, dynamic> json = jsonDecode(jsonString);
    return Word(
      word: json["word"] ?? "",
      pos: json["pos"] ?? "",
      phonetic: json["phonetic"] ?? "",
      phoneticText: json["phonetic_text"] ?? "",
      phoneticAm: json["phonetic_am"] ?? "",
      phoneticAmText: json["phonetic_am_text"] ?? "",
      senses: (json["senses"] as List).map((e) => Sense.fromMap(e)).toList(),
      index: json["index"],
      img: json["img"] ?? "",
      pronunciation: json["pronunciation"] ?? "",
      id: json["id"] ?? "",
      lastLearned: json["lastLearned"] ?? "",
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
      "img": img,
      "pronunciation": pronunciation,
      "id": id,
      "lastLearned": lastLearned,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map["id"] ?? "",
      phonetic: map["phoenetic"] ?? "",
      phoneticAm: map["phoenetic_am"] ?? "",
      phoneticAmText: map["phoenetic_am_text"] ?? "",
      phoneticText: map["phoenetic_text"] ?? "",
      pos: map["pos"] ?? "",
      senses: map["senses"] ?? "",
      word: map["word"] ?? "",
      img: map["word"] ?? "",
      index: map["index"] ?? 0,
      pronunciation: map["pronunciation"] ?? "",
      lastLearned: map["lastLearned"] ?? "",
    );
  }

  // Chuyển từ Object Dart sang JSON String
  String toJson() {
    return jsonEncode(toMap());
  }

  Word copyWith({
    String? word,
    String? pos,
    String? phonetic,
    String? phoneticText,
    String? phoneticAm,
    String? phoneticAmText,
    List<Sense>? senses,
    int? index,
    String? img,
    String? pronunciation,
    String? id,
    String? lastLearned,
  }) {
    return Word(
      word: word ?? this.word,
      pos: pos ?? this.pos,
      phonetic: phonetic ?? this.phonetic,
      phoneticText: phoneticText ?? this.phoneticText,
      phoneticAm: phoneticAm ?? this.phoneticAm,
      phoneticAmText: phoneticAmText ?? this.phoneticAmText,
      senses: senses ?? this.senses,
      index: index ?? this.index,
      img: img ?? this.img,
      pronunciation: pronunciation ?? this.pronunciation,
      id: id ?? this.id,
      lastLearned: lastLearned ?? this.lastLearned,
    );
  }
}

// class WordList {
//   List<Word> words;

//   WordList({required this.words});

//   // Chuyển từ JSON String sang danh sách WordEntry
//   factory WordList.fromJson(Map<String, dynamic> json) {
//     // List<dynamic> jsonList = jsonDecode(jsonString);
//     return WordList(
//       // words: jsonList.map((e) => Word.fromJson(jsonEncode(e))).toList(),
//       words: json
//     );
//   }

//   // Chuyển danh sách WordEntry sang Map
//   Map<String, dynamic> toMap() {
//     return {
//       "words": words.map((e) => e.toMap()).toList(),
//     };
//   }

//   // Chuyển danh sách WordEntry sang JSON String
//   String toJson() {
//     return jsonEncode(toMap());
//   }
// }
