import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GetViewModelBase extends GetxController {
  static GetViewModelBase get to => Get.find();
  BuildContext? context;
  var loading = false.obs;
  var loadingMore = false.obs;
  int skip = 0;
  int limit = 20;
  bool loadMoreDone = false;
}
