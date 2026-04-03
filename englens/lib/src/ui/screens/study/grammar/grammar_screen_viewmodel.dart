import 'package:englens/src/core/constants/app_constants.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_lessons/grammar_lessons_screen.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_lessons/grammar_lessons_screen_viewmodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrammarRowItem {
  final String title;
  final String subtitle;
  final GrammarLessonType type;
  final double progress;
  GrammarRowItem({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.progress,
  });
}

class GrammarScreenViewmodel extends GetViewModelBase {
  // List<MarkDownProps> get markDownProps => _markDownProps.value;
  List<GrammarRowItem> listGrammarRowItem = [];
  late SharedPreferences prefs;
  List<String> listTenses = [];
  List<String> listSenteces = [];
  List<String> listWords = [];
  List<String> listOthers = [];

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();
    listTenses = prefs.getStringList(AppConstants.grammarTensesPrefsKey) ?? [];
    listSenteces =
        prefs.getStringList(AppConstants.grammarSentencesPrefsKey) ?? [];
    listWords = prefs.getStringList(AppConstants.grammarWordsPrefsKey) ?? [];
    listOthers = prefs.getStringList(AppConstants.grammarOthersPrefsKey) ?? [];

    listGrammarRowItem = [
      GrammarRowItem(
        title: "Tenses",
        subtitle: "13 tenses in English",
        type: GrammarLessonType.tenses,
        progress: (listTenses.length.toDouble() / 13) * 100,
      ),
      GrammarRowItem(
        title: "Sentences",
        subtitle: "Sentences in English",
        type: GrammarLessonType.sentences,
        progress: (listSenteces.length.toDouble() / 8) * 100,
      ),
      GrammarRowItem(
        title: "Words",
        subtitle: "Words in English",
        type: GrammarLessonType.words,
        progress: listWords.length.toDouble() / 9 * 100,
      ),
      GrammarRowItem(
        title: "Others",
        subtitle: "Other grammar topics",
        type: GrammarLessonType.others,
        progress: listOthers.length.toDouble() / 5 * 100,
      ),
    ];

    update();
  }

  void onTapToGrammarLessons(int index) {
    Get.toNamed(
      GrammarLessonsScreen.routeName,
      arguments: GrammarLessonsScreenArgs(
        title: listGrammarRowItem[index].title,
        type: listGrammarRowItem[index].type,
      ),
    )!.then((value) {
      initData();
    });
  }
}
