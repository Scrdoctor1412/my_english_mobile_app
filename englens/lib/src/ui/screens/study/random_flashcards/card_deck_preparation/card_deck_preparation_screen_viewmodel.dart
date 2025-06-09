// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';

class CardDeckPreparationScreenArgs {
  final List<Word>? words;
  CardDeckPreparationScreenArgs({
    this.words,
  });
}

class CardDeckPreparationScreenViewmodel extends GetViewModelBase {
  List<Word> words = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      CardDeckPreparationScreenArgs args =
          Get.arguments as CardDeckPreparationScreenArgs;
      words = args.words ?? [];
    }
  }
}
