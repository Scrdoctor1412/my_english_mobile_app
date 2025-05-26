// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:englens/src/data/models/word.dart';

class UserWordList {
  String? id;
  String name;
  List<Word> wordList;

  UserWordList({
    this.id,
    required this.name,
    required this.wordList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'wordList': wordList.map((x) => x.toMap()).toList(),
    };
  }

  factory UserWordList.fromMap(Map<String, dynamic> map) {
    return UserWordList(
      id: map['id'] as String,
      name: map['name'] as String,
      wordList: List<Word>.from(
        (map['wordList'] as List<dynamic>).map<Word>(
          (x) => Word.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserWordList.fromJson(String source) =>
      UserWordList.fromMap(json.decode(source) as Map<String, dynamic>);
}
