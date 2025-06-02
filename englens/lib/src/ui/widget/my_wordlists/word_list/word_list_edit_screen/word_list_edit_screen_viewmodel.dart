// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordListEditScreenArgs {
  final Word word;
  WordListEditScreenArgs({
    required this.word,
  });
}

class WordListEditScreenViewmodel extends GetViewModelBase {
  late Word word;

  TextEditingController wordController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      final args = Get.arguments as WordListEditScreenArgs;
      word = args.word;
    }
  }
}
