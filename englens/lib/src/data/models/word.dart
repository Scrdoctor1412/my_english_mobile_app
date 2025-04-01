import 'dart:convert';

class WordEntry {
  final String word;
  final String pos;
  final String phonetic;
  final String phoneticText;
  final String phoneticAm;
  final String phoneticAmText;
  final List<Sense> senses;

  WordEntry({
    required this.word,
    required this.pos,
    required this.phonetic,
    required this.phoneticText,
    required this.phoneticAm,
    required this.phoneticAmText,
    required this.senses,
  });

  // Chuyển từ JSON String sang WordEntry
  factory WordEntry.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return WordEntry(
      word: json["word"],
      pos: json["pos"],
      phonetic: json["phonetic"],
      phoneticText: json["phonetic_text"],
      phoneticAm: json["phonetic_am"],
      phoneticAmText: json["phonetic_am_text"],
      senses: (json["senses"] as List).map((e) => Sense.fromMap(e)).toList(),
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
    };
  }

  // Chuyển từ Object Dart sang JSON String
  String toJson() {
    return jsonEncode(toMap());
  }
}

class Sense {
  final String definition;
  final List<Example> examples;

  Sense({
    required this.definition,
    required this.examples,
  });

  factory Sense.fromMap(Map<String, dynamic> json) {
    return Sense(
      definition: json["definition"],
      examples:
          (json["examples"] as List).map((e) => Example.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "definition": definition,
      "examples": examples.map((e) => e.toMap()).toList(),
    };
  }
}

class Example {
  final String cf;
  final String x;

  Example({
    required this.cf,
    required this.x,
  });

  factory Example.fromMap(Map<String, dynamic> json) {
    return Example(
      cf: json["cf"],
      x: json["x"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "cf": cf,
      "x": x,
    };
  }
}

class WordEntryList {
  final List<WordEntry> words;

  WordEntryList({required this.words});

  // Chuyển từ JSON String sang danh sách WordEntry
  factory WordEntryList.fromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    return WordEntryList(
      words: jsonList.map((e) => WordEntry.fromJson(jsonEncode(e))).toList(),
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
