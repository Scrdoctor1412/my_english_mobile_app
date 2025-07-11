import 'dart:math';

import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/repositories/oxford_words_repository.dart';
import 'package:englens/src/service/learning_record_service.dart';
import 'package:englens/src/ui/screens/home/leitner_daily_words/leitner_daily_words_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenViewmodel extends GetViewModelBase {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final oxfordRepo = Get.find<OxfordWordsRepositoryImpl>();
  late List<Word> listOxfordWords = [];
  late List<Word> listRandomWords = [];
  List<String> todaLearnWordsIds = [];

  double indicatorValue = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listOxfordWords = oxfordRepo.getAllOxfordWords();
    onInitRandomWords();
    initData();
  }

  void initData() {
    var learningRecords = LearningRecordService.getLearningRecords();
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    String now = formatter.format(DateTime.now());
    for (var record in learningRecords) {
      if (record.id == now) {
        todaLearnWordsIds = record.wordIds ?? [];
      }
    }
    indicatorValue = todaLearnWordsIds.length / 5;
    if (indicatorValue > 1) {
      indicatorValue = 1;
    }
    update();
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

  void onTapToLeinerDailyWords() {
    Get.toNamed(LeitnerDailyWordsScreen.routeName)!.then(
      (value) {
        initData();
      },
    );
  }
}
