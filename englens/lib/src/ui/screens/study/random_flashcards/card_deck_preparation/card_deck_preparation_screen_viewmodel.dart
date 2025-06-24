// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/local_word_service.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
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
    } else {
      initData();
    }
  }

  void initData() async {
    words = await LocalWordService.getAllWordsFromLocal();
    words.shuffle();
    words = words.take(10).toList();
    update();
  }

  void onTapLearnNow() {
    Get.toNamed(
      FlashcardsScreen.routeName,
      arguments: FlashcardsScreenArgs(
        title: "Random 10 words",
        wordList: words,
      ),
    );
  }
}
