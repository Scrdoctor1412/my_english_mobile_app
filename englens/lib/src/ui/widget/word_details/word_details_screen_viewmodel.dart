import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/ui/widget/complete/complete_screen.dart';
import 'package:englens/src/ui/widget/complete/complete_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/word.dart';

class WordDetailsScreenViewmodelArgs {
  final List<Word>? words;
  final String? lessonTitle;
  final List<Word>? onlyWord;
  final bool? isFromLessonDetailsScreen;

  WordDetailsScreenViewmodelArgs({
    this.words,
    this.lessonTitle,
    this.onlyWord,
    this.isFromLessonDetailsScreen,
  });
}

class WordDetailsScreenViewmodel extends GetViewModelBase {
  List<Word> words = [];
  String lessonTitle = '';
  List<Word>? onlyWord;
  bool isFromLessonDetailsScreen = false;
  final player = AudioPlayer();
  late double progressValue;
  int pageCurrentIndex = 0;
  int pageLastIndex = 0;

  //list temp words use for creating space to swipe to complete screen after user's complete reviewing
  List<Word> tempWords = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      WordDetailsScreenViewmodelArgs args = Get.arguments;
      words = args.words ?? [];
      lessonTitle = args.lessonTitle ?? "";
      isFromLessonDetailsScreen = args.isFromLessonDetailsScreen ?? false;
      onlyWord = args.onlyWord ?? null;
    }
    for (var word in words) {
      tempWords.add(word);
    }
    //dummy word
    tempWords.add(Word(
        word: "",
        pos: "",
        phonetic: "",
        phoneticText: "",
        phoneticAm: "",
        phoneticAmText: "",
        senses: [Sense(definition: "", examples: [])]));
    progressValue = 1 / words.length;
  }

  void onChangePage(int index) {
    if (index > words.length - 1) {
      onToCompleteScreen();
    }
    pageLastIndex = pageCurrentIndex;
    pageCurrentIndex = index;
    if (pageCurrentIndex > pageLastIndex) {
      progressValue += 1 / words.length;
    } else if (pageCurrentIndex < pageLastIndex) {
      progressValue -= 1 / words.length;
    }

    update();
  }

  void onToCompleteScreen() {
    Get.offNamed(
      CompleteScreen.routeName,
      arguments: CompleteScreenArgs(
        title: lessonTitle,
        flashcardArgs: FlashcardsScreenArgs(
          title: lessonTitle,
          wordList: words,
        ),
        type: CompleteScreenType.wordReview,
      ),
    );
  }

  void onTapPlayAudio(String audioUrl) async {
    await player.setUrl(audioUrl);
    player.play();
  }
}
