import 'dart:convert';

import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnglishHandbookScreenViewmodel extends GetViewModelBase {
  Future<void> readJson() async {
    final String res =
        await rootBundle.loadString('assets/json/oxford_words/a.json');
    // print(res);
    // final data = await json.decode(res);
    // Word word = Word.fromJson(res);
    // debugPrint(word.toString());
    WordEntryList data = WordEntryList.fromJson(res);
    print(data.words.toString());
  }
}
