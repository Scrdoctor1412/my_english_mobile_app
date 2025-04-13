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
    progressValue = 1 / words.length;
  }

  void onChangePage(int index) {
    pageLastIndex = pageCurrentIndex;
    pageCurrentIndex = index;
    if (pageCurrentIndex > pageLastIndex) {
      progressValue += 1 / words.length;
    } else if (pageCurrentIndex < pageLastIndex) {
      progressValue -= 1 / words.length;
    }

    update();
  }

  void onTapPlayAudio(String audioUrl) async {
    await player.setUrl(audioUrl);
    player.play();
  }
}
