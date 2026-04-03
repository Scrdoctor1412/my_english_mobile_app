import 'package:englens/src/core/gen/assets.gen.dart';
import 'package:englens/src/core/constants/app_constants.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_lessons_details/grammar_lessons_details_screen.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_lessons_details/grammar_lessons_details_screen_viewmodel.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum GrammarLessonType { tenses, sentences, words, others }

class GrammarLessonsScreenArgs {
  final String title;
  final GrammarLessonType type;
  GrammarLessonsScreenArgs({required this.title, required this.type});
}

class MarkDownProps {
  final String id;
  final String? data;
  final String assetLink;
  final String? title;
  final String? subTitle;

  MarkDownProps({
    required this.id,
    this.data,
    this.title,
    required this.assetLink,
    this.subTitle,
  });

  MarkDownProps copyWith({
    String? id,
    String? data,
    String? title,
    String? subTitle,
    String? assetLink,
  }) {
    return MarkDownProps(
      data: data ?? this.data,
      title: title ?? this.title,
      assetLink: assetLink ?? this.assetLink,
      subTitle: subTitle ?? this.subTitle,
      id: id ?? this.id,
    );
  }
}

class GrammarLessonsScreenViewmodel extends GetViewModelBase {
  late SharedPreferences prefs;
  List<MarkDownProps>? listTenses;
  List<MarkDownProps>? listSenteces;
  List<MarkDownProps>? ListWords;
  List<MarkDownProps>? ListOthers;

  List<MarkDownProps> listMdProps = [];
  List<bool> listMdPropsCheckValue = [];

  late String title;
  late GrammarLessonType type;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      GrammarLessonsScreenArgs args = Get.arguments;
      title = args.title;
      type = args.type;
    }
    initData();
  }

  void initData() async {
    // var data = await _loadMarkDown();
    switch (type) {
      case GrammarLessonType.words:
        initWords();
        listMdProps = ListWords!;
        break;
      case GrammarLessonType.sentences:
        initSentences();
        listMdProps = listSenteces!;
        break;
      case GrammarLessonType.tenses:
        initTenses();
        listMdProps = listTenses!;
        break;
      case GrammarLessonType.others:
        initOthers();
        listMdProps = ListOthers!;
        break;
    }
    listMdPropsCheckValue = List.generate(listMdProps.length, (index) => false);
    prefs = await SharedPreferences.getInstance();
    var list = getGrammarLessonsPrefsList();
    if (list.isNotEmpty) {
      for (var item in list) {
        listMdPropsCheckValue[int.parse(item) - 1] = true;
      }
    }
    update();
  }

  void onTapCheckLessons(bool value, int index) {
    listMdPropsCheckValue[index] = !listMdPropsCheckValue[index];
    switch (type) {
      case GrammarLessonType.words:
        updateGrammarLessonsPrefs(
          value,
          index,
          AppConstants.grammarWordsPrefsKey,
        );
        break;
      case GrammarLessonType.sentences:
        updateGrammarLessonsPrefs(
          value,
          index,
          AppConstants.grammarSentencesPrefsKey,
        );
        break;
      case GrammarLessonType.tenses:
        updateGrammarLessonsPrefs(
          value,
          index,
          AppConstants.grammarTensesPrefsKey,
        );
        break;
      case GrammarLessonType.others:
        updateGrammarLessonsPrefs(
          value,
          index,
          AppConstants.grammarOthersPrefsKey,
        );
        break;
    }
    update();
  }

  List<String> getGrammarLessonsPrefsList() {
    List<String> list = [];
    switch (type) {
      case GrammarLessonType.words:
        list = prefs.getStringList(AppConstants.grammarWordsPrefsKey) ?? [];
        break;
      case GrammarLessonType.sentences:
        list = prefs.getStringList(AppConstants.grammarSentencesPrefsKey) ?? [];
        break;
      case GrammarLessonType.tenses:
        list = prefs.getStringList(AppConstants.grammarTensesPrefsKey) ?? [];
        break;
      case GrammarLessonType.others:
        list = prefs.getStringList(AppConstants.grammarOthersPrefsKey) ?? [];
        break;
    }
    return list;
  }

  void updateGrammarLessonsPrefs(bool value, int index, String key) {
    var list = prefs.getStringList(key) ?? [];
    if (value) {
      //Kiểm tra trùng trước khi thêm
      var isDuplicate = list.indexWhere(
        (element) => element == (index + 1).toString(),
      );
      //Không trùng thì thêm vào danh sách
      if (isDuplicate == -1) {
        list.add(listMdProps[index].id);
      }
    } else {
      //Trường hơp uncheck checkbox -> xóa khỏi danh sách
      list.removeWhere((element) => element == listMdProps[index].id);
    }
    prefs.setStringList(key, list);
  }

  void onTapToGrammarLessonDetails(int index) {
    Get.toNamed(
      GrammarLessonsDetailsScreen.routeName,
      arguments: GrammarLessonsDetailsScreenArgs(
        asssetLink: listMdProps[index].assetLink,
      ),
    );
  }

  void initTenses() {
    listTenses = [
      MarkDownProps(
        id: 1.toString(),
        assetLink: Assets.md.grammar.tenses.present.simplePresentTense,
        title: "Simple Present Tense",
        subTitle: "S + to be/V + O",
      ),
      MarkDownProps(
        id: 2.toString(),
        assetLink: Assets.md.grammar.tenses.present.presentContinuousTense,
        title: "Present Continuous Tense",
        subTitle: "P + to be/V-ing + O",
      ),
      MarkDownProps(
        id: 3.toString(),
        assetLink: Assets.md.grammar.tenses.present.presentPerfectTense,
        title: "Present Perfect Tense",
        subTitle: "P + have/has + V3 + O",
      ),
      MarkDownProps(
        id: 4.toString(),
        assetLink:
            Assets.md.grammar.tenses.present.presentPerfectContinuousTense,
        title: "Present Perfect Continuous Tense",
        subTitle: "P + have/has + been + V-ing + O",
      ),
      MarkDownProps(
        id: 5.toString(),
        assetLink: Assets.md.grammar.tenses.past.simplePastTense,
        title: "Simple Past Tense",
        subTitle: "S + V2 + O",
      ),
      MarkDownProps(
        id: 6.toString(),
        assetLink: Assets.md.grammar.tenses.past.pastContinuousTense,
        title: "Past Continuous Tense",
        subTitle: "P + was/were + V-ing + O",
      ),
      MarkDownProps(
        id: 7.toString(),
        assetLink: Assets.md.grammar.tenses.past.pastPerfectTense,
        title: "Past Perfect Tense",
        subTitle: "P + had + V3 + O",
      ),
      MarkDownProps(
        id: 8.toString(),
        assetLink: Assets.md.grammar.tenses.past.pastPerfectContinuousTense,
        title: "Past Perfect Continuous Tense",
        subTitle: "P + had + been + V-ing + O",
      ),
      MarkDownProps(
        id: 9.toString(),
        assetLink: Assets.md.grammar.tenses.future.futureSimpleTense,
        title: "Simple Future Tense",
        subTitle: "S + will + V + O",
      ),
      MarkDownProps(
        id: 10.toString(),
        assetLink: Assets.md.grammar.tenses.future.futureContinuousTense,
        title: "Future Continuous Tense",
        subTitle: "P + will + V-ing + O",
      ),
      MarkDownProps(
        id: 11.toString(),
        assetLink: Assets.md.grammar.tenses.future.futurePerfectTense,
        title: "Future Perfect Tense",
        subTitle: "P + will have + V3 + O",
      ),
      MarkDownProps(
        id: 12.toString(),
        assetLink: Assets.md.grammar.tenses.future.futurePerfectContinuousTense,
        title: "Future Perfect Continuous Tense",
        subTitle: "P + will have + been + V-ing + O",
      ),
      MarkDownProps(
        id: 13.toString(),
        assetLink: Assets.md.grammar.tenses.future.nearFuture,
        title: "Near Future",
        subTitle: "S + to be + going to + V + O",
      ),
    ];
  }

  void initSentences() {
    listSenteces = [
      MarkDownProps(
        id: 1.toString(),
        assetLink: Assets.md.grammar.sentences.passiveVoice,
        title: "Passive Voice",
        subTitle: "Emphasis the action rather than the doer",
      ),
      MarkDownProps(
        id: 2.toString(),
        assetLink: Assets.md.grammar.sentences.reportedSpeech,
        title: "Reported Speech",
        subTitle: "Report what someone else said",
      ),
      MarkDownProps(
        id: 3.toString(),
        assetLink: Assets.md.grammar.sentences.conditionalSentences,
        title: "Conditional Sentences",
        subTitle: "4 types of conditional sentences",
      ),
      MarkDownProps(
        id: 4.toString(),
        assetLink: Assets.md.grammar.sentences.wishSentences,
        title: "Wish Sentences",
        subTitle: "Express regret or desire",
      ),
      MarkDownProps(
        id: 5.toString(),
        assetLink: Assets.md.grammar.sentences.questionTags,
        title: "Question Tags",
        subTitle: "Short questions at the end of a sentence",
      ),
      MarkDownProps(
        id: 6.toString(),
        assetLink: Assets.md.grammar.sentences.imperativeSentences,
        title: "Imperative Sentences",
        subTitle: "Give orders or instructions",
      ),
      MarkDownProps(
        id: 7.toString(),
        assetLink: Assets.md.grammar.sentences.comparisonSentences,
        title: "Comparison Sentences",
        subTitle: "Compare two or more things",
      ),
      MarkDownProps(
        id: 8.toString(),
        assetLink: Assets.md.grammar.sentences.exclamatorySentences,
        title: "Exclamatory Sentences",
        subTitle: "Express strong feelings",
      ),
    ];
  }

  void initWords() {
    ListWords = [
      MarkDownProps(
        id: 1.toString(),
        assetLink: Assets.md.grammar.words.wordFamilies.nouns,
        title: "Nouns",
        subTitle: "Person, place, thing or idea",
      ),
      MarkDownProps(
        id: 2.toString(),
        assetLink: Assets.md.grammar.words.pronouns,
        title: "Pronouns",
        subTitle: "Replace nouns",
      ),
      MarkDownProps(
        id: 3.toString(),
        assetLink: Assets.md.grammar.words.wordFamilies.adjectives,
        title: "Adjectives",
        subTitle: "Describe nouns",
      ),
      MarkDownProps(
        id: 4.toString(),
        assetLink: Assets.md.grammar.words.wordFamilies.adverbs,
        title: "Adverbs",
        subTitle: "Describe verbs, adjectives, or other adverbs",
      ),
      MarkDownProps(
        id: 5.toString(),
        assetLink: Assets.md.grammar.words.preposition,
        title: "Prepositions",
        subTitle: "Show the relationship between a noun and another word",
      ),
      MarkDownProps(
        id: 6.toString(),
        assetLink: Assets.md.grammar.words.conjunction,
        title: "Conjunctions",
        subTitle: "Connect words, phrases, or clauses",
      ),
      MarkDownProps(
        id: 7.toString(),
        assetLink: Assets.md.grammar.words.interjection,
        title: "Interjections",
        subTitle: "Express strong feelings or emotions",
      ),
      MarkDownProps(
        id: 8.toString(),
        assetLink: Assets.md.grammar.words.article,
        title: "Articles",
        subTitle: "A, an, the",
      ),
      MarkDownProps(
        id: 9.toString(),
        assetLink: Assets.md.grammar.words.modalVerbs,
        title: "Modals Verbs",
        subTitle: "Can, could, may, might, must, shall, should, will, would",
      ),
    ];
  }

  void initOthers() {
    ListOthers = [
      MarkDownProps(
        id: 1.toString(),
        assetLink: Assets.md.grammar.words.wordFamilies.wordFamilies,
        title: "Word Families",
        subTitle: "Words that are related to each other",
      ),
      MarkDownProps(
        id: 2.toString(),
        assetLink: Assets.md.grammar.phrasalVerbs,
        title: "Phrasal Verbs",
        subTitle: "Verb + preposition or adverb",
      ),
      MarkDownProps(
        id: 3.toString(),
        assetLink: Assets.md.grammar.idioms,
        title: "Ididoms",
        subTitle:
            "Expressions that have a meaning different from the meaning of the individual words",
      ),
      MarkDownProps(
        id: 4.toString(),
        assetLink: Assets.md.grammar.proverbs,
        title: "Proverbs",
        subTitle: "Short sayings that give advice or express a belief",
      ),
      MarkDownProps(
        id: 5.toString(),
        assetLink: Assets.md.grammar.quantifiers,
        title: "Quantifiers",
        subTitle: "Words that describe quantity",
      ),
    ];
  }
}
