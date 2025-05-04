import 'dart:math';

import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenViewmodel extends GetViewModelBase {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final oxfordRepo = Get.find<OxfordWordsRepositoryImpl>();
  late List<Word> listOxfordWords = [];
  late List<Word> listRandomWords = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listOxfordWords = oxfordRepo.getAllOxfordWords();
    onInitRandomWords();
  }

  void onInitRandomWords() {
    final random = Random();

    listRandomWords = [
      ...List.generate(5, (index) {
        int randomtIndex = random.nextInt(listOxfordWords.length);
        return listOxfordWords[randomtIndex];
      })
    ];
    update();
  }
}
