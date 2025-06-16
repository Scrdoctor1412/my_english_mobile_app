import 'dart:convert';

import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/data/models/level_based.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

abstract interface class AssetsData extends GetxController {
  Future<List<Word>> getOxfordWordsByLetter(String letter);
  Future<List<Word>> getAllOxfordWords();
  Future<List<Lesson>> getAllTopicsLesson(String topic);
  Future<List<Topic>> getAllTopics();
  Future<List<LevelBased>> getAllLevelBased();
  Future<List<Lesson>> getAllLevelBasedLesson(String level);
  Future<List<Idioms>> getAllIdioms();
  Future<List<Collocations>> getAllCollocations();
  Future<List<EngProverbs>> getAllEngProverbs();
  Future<List<PhrasalVerbs>> getAllPhrasalVerbs();
  Future<List<Lesson>> getAllIdiomsLesson(String topic);
  Future<List<Lesson>> getAllCollocationsLesson(String topic);
  Future<List<Lesson>> getAllEngProverbsLesson(String topic);
  Future<List<Lesson>> getAllPhrasalVerbsLesson(String topic);

  Future<List<LearningCategory>> getAllTopicsCat();
  Future<List<LearningCategory>> getAllLevelBasedCat();
  Future<List<LearningCategory>> getAllIdiomsCat();
  Future<List<LearningCategory>> getAllCollocationsCat();
  Future<List<LearningCategory>> getAllEngProverbsCat();
  Future<List<LearningCategory>> getAllPhrasalVerbsCat();

  Future<List<Word>> getAllTopicsWords();
  Future<List<Word>> getAllLevelBasedWords();
  Future<List<Word>> getAllIdiomsWords();
  Future<List<Word>> getAllCollocationsWords();
  Future<List<Word>> getAllEngProverbsWords();
  Future<List<Word>> getAllPhrasalVerbsWords();
}

class AssetsDataImpl extends GetxController implements AssetsData {
  var uuid = const Uuid();

  @override
  Future<List<Word>> getOxfordWordsByLetter(String letter) async {
    final path = 'assets/json/oxford_words/$letter.json';
    final jsonString = await rootBundle.loadString(path);
    // final json = jsonDecode(jsonString);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Word.fromJson(json)).toList();

    // WordList data = WordList.fromJson(jsonString);
    // final List<dynamic> jsonList = json.decode(jsonString);
    // return jsonList.map((json) => Word.fromJson(json)).toList();
    // return data.words;
  }

  @override
  Future<List<Word>> getAllOxfordWords() async {
    final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
    final List<Word> words = [];
    for (final letter in letters) {
      final List<Word> wordsByLetter = await getOxfordWordsByLetter(letter);
      words.addAll(wordsByLetter);
    }
    return words;
  }

  @override
  Future<List<Lesson>> getAllTopicsLesson(String topic) async {
    // TODO: implement getAllTopicsWords
    return await parseTopicsLessons(topic);
  }

  Future<List<Lesson>> parseTopicsLessons(String topic) async {
    // final List<String> jsonStrings = [];
    final path = 'assets/json/topics_words/$topic';

    const topicCase = {
      "agreement_and_disagreement": 16,
      "animals": 54,
      "appearance": 17,
      "art": 26,
      "body": 18,
      "certainty_and_doubt": 8,
      "cinema_and_theater": 15,
      "colors_and_shapes": 21,
      "decision_suggestion_obligation": 18,
      "eating_drinking_and_serving": 11,
      "education": 42,
      "food_and_drink_preparation": 17,
      "food_and_drinks": 40,
      "food_ingredients": 28,
      "health_and_sickness": 21,
      "hobbies_games": 27,
      "land_transportation": 37,
      "literature": 18,
      "music": 29,
      "opinion_and_argument": 10,
      "personal_care": 15,
      "sports": 62,
      "words_related_to_architecture_and_construction": 37,
      "words_related_to_home_and_garden": 26,
      "words_related_to_linguistics": 23,
      "words_related_to_media_and_communication": 28,
      "words_related_to_medical_science": 27,
      "words_related_to_performing_arts": 15
    };

    final end = topicCase[topic] ?? 0;

    final jsonStrings = await Future.wait(
      List.generate(
        end + 1,
        (i) => rootBundle.loadString('$path/lesson_$i.json'),
      ),
    );
    return compute(_parseLessons, jsonStrings);
  }

  Future<List<Lesson>> _parseLessons(List<String> jsonStrings) async {
    return jsonStrings.map((jsonString) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return Lesson.fromJson(jsonMap);
    }).toList();
  }

  @override
  Future<List<Topic>> getAllTopics() async {
    // TODO: implement getAllTopics
    List<String> topicNames = [
      "agreement_and_disagreement",
      "animals",
      "appearance",
      "art",
      "body",
      "certainty_and_doubt",
      "cinema_and_theater",
      "colors_and_shapes",
      "decision_suggestion_obligation",
      "eating_drinking_and_serving",
      "education",
      "food_and_drink_preparation",
      "food_and_drinks",
      "food_ingredients",
      "health_and_sickness",
      "hobbies_games",
      "land_transportation",
      "literature",
      "music",
      "opinion_and_argument",
      "personal_care",
      "sports",
      "words_related_to_architecture_and_construction",
      "words_related_to_home_and_garden",
      "words_related_to_linguistics",
      "words_related_to_media_and_communication",
      "words_related_to_medical_science",
      "words_related_to_performing_arts"
    ];

    List<Topic> topics = [];
    for (var topic in topicNames) {
      List<Lesson> lessons = await getAllTopicsLesson(topic);
      Topic topicModel = Topic(
        title: topic,
        lessons: lessons,
      );
      topics.add(topicModel);
    }
    return topics;
  }

  @override
  Future<List<LevelBased>> getAllLevelBased() async {
    // TODO: implement getAllLevelBased
    List<String> levelBasedNames = [
      "a1_level",
      "a2_level",
      "b1_level",
      "b2_level",
      "c1_level",
      "c2_level",
    ];

    List<LevelBased> levelBasedList = [];
    for (var levelBased in levelBasedNames) {
      var lessons = await getAllLevelBasedLesson(levelBased);
      LevelBased levelBasedModel = LevelBased(
        title: levelBased,
        lessons: lessons,
      );
      levelBasedList.add(levelBasedModel);
    }
    return levelBasedList;
  }

  Future<List<Lesson>> parseLevelBasedLessons(String levelBased) async {
    // final List<String> jsonStrings = [];
    final path = 'assets/json/wordlist_by_level_words/$levelBased';

    const topicCase = {
      'a1_level': 31,
      'a2_level': 49,
      'b1_level': 57,
      'b2_level': 63,
      'c1_level': 66,
      'c2_level': 88,
    };

    final end = topicCase[levelBased] ?? 0;

    final jsonStrings = await Future.wait(
      List.generate(
        end + 1,
        (i) => rootBundle.loadString('$path/lesson_$i.json'),
      ),
    );
    return compute(_parseLessons, jsonStrings);
  }

  @override
  Future<List<Lesson>> getAllLevelBasedLesson(String level) async {
    // TODO: implement getAllLevelBasedLesson
    // throw UnimplementedError();
    return await parseLevelBasedLessons(level);
  }

  @override
  Future<List<Collocations>> getAllCollocations() async {
    List<String> topics = [
      "collocations_of_be_place_put_and_more",
      "collocations_of_do_set_go",
      "collocations_of_give_keep_come",
      "collocations_of_make_take_have",
      "collocations_of_pay_run_break_and_more",
      "collocations_with_other_verbs",
      "compound_adverbs",
      "compound_prepositions",
    ];
    List<Collocations> collocations = [];
    for (var topic in topics) {
      var lessons = await getAllCollocationsLesson(topic);
      Collocations collocationsModel = Collocations(
        title: topic,
        lessons: lessons,
      );
      collocations.add(collocationsModel);
    }
    return collocations;
  }

  @override
  Future<List<Lesson>> getAllCollocationsLesson(String topic) async {
    // return await compute(parseCollocationsLessons, topic);
    return await parseCollocationsLessons(topic);
  }

  Future<List<Lesson>> parseCollocationsLessons(String topic) async {
    var collocations_data = {
      "collocations_of_be_place_put_and_more": 6,
      "collocations_of_do_set_go": 6,
      "collocations_of_give_keep_come": 5,
      "collocations_of_make_take_have": 9,
      "collocations_of_pay_run_break_and_more": 4,
      "collocations_with_other_verbs": 7,
      "compound_adverbs": 8,
      "compound_prepositions": 10,
    };
    final end = collocations_data[topic] ?? 0;
    final path = 'assets/json/expressions/collocations/$topic';
    final jsonStrings = await Future.wait(
      List.generate(
        end + 1,
        (i) => rootBundle.loadString('$path/lesson_$i.json'),
      ),
    );
    return compute(_parseLessons, jsonStrings);
  }

  @override
  Future<List<EngProverbs>> getAllEngProverbs() async {
    List<String> topics = [
      "behavior_attitude_approach",
      "daily_life",
      "human_relationships",
      "human_traits_qualities",
      "knowledge_wisdom",
      "notions_feelings",
      "outcome_impact",
      "perseverance",
      "qualities",
      "situations_states",
      "social_interaction",
      "society_law_politics",
      "virtue_vice",
      "wealth_success",
    ];

    List<EngProverbs> engProverbs = [];
    for (var topic in topics) {
      var lessons = await getAllEngProverbsLesson(topic);
      EngProverbs engProverbsModel = EngProverbs(
        title: topic,
        lessons: lessons,
      );
      engProverbs.add(engProverbsModel);
    }
    return engProverbs;
  }

  @override
  Future<List<Lesson>> getAllEngProverbsLesson(String topic) {
    // return compute(parseEngProverbsLessons, topic);
    return parseEngProverbsLessons(topic);
  }

  Future<List<Lesson>> parseEngProverbsLessons(String topic) async {
    var topic_categories = {
      "behavior_attitude_approach": 17,
      "daily_life": 6,
      "human_relationships": 6,
      "human_traits_qualities": 9,
      "knowledge_wisdom": 10,
      "notions_feelings": 9,
      "outcome_impact": 6,
      "perseverance": 8,
      "qualities": 10,
      "situations_states": 9,
      "social_interaction": 8,
      "society_law_politics": 7,
      "virtue_vice": 6,
      "wealth_success": 9,
    };
    final end = topic_categories[topic] ?? 0;
    final path = 'assets/json/expressions/eng_proverbs/$topic';
    final jsonStrings = await Future.wait(
      List.generate(
          end + 1, (i) => rootBundle.loadString('$path/lesson_$i.json')),
    );
    return compute(_parseLessons, jsonStrings);
  }

  @override
  Future<List<Idioms>> getAllIdioms() async {
    List<String> topics = [
      "amounts",
      "behavior_approach",
      "certainty_possibility",
      "danger",
      "decision_control",
      "describing_people",
      "describing_qualities",
      "difficulty",
      "everyday_life",
      "failure",
      "feelings",
      "influence_involvement",
      "interactions",
      "knowledge_understanding",
      "opinion",
      "perseverance",
      "personality",
      "relationship",
      "society_law_politics",
      "success",
      "time",
      "truth_secrecy_deception",
      "work_money",
    ];
    List<Idioms> idioms = [];
    for (var topic in topics) {
      var lessons = await getAllIdiomsLesson(topic);
      Idioms idiomsModel = Idioms(title: topic, lessons: lessons);
      idioms.add(idiomsModel);
    }
    return idioms;
  }

  @override
  Future<List<Lesson>> getAllIdiomsLesson(String topic) async {
    return await parseIdiomsLessons(topic);
  }

  Future<List<Lesson>> parseIdiomsLessons(String topic) async {
    var vocabulary_categories = {
      "amounts": 6,
      "behavior_approach": 16,
      "certainty_possibility": 10,
      "danger": 8,
      "decision_control": 9,
      "describing_people": 9,
      "describing_qualities": 15,
      "difficulty": 10,
      "everyday_life": 12,
      "failure": 10,
      "feelings": 11,
      "influence_involvement": 11,
      "interactions": 12,
      "knowledge_understanding": 12,
      "opinion": 10,
      "perseverance": 8,
      "personality": 11,
      "relationship": 8,
      "society_law_politics": 11,
      "success": 11,
      "time": 10,
      "truth_secrecy_deception": 10,
      "work_money": 11
    };

    final end = vocabulary_categories[topic] ?? 0;
    final path = 'assets/json/expressions/idioms/$topic';
    final jsonStrings = await Future.wait(
      List.generate(
        end + 1,
        (i) => rootBundle.loadString('$path/lesson_$i.json'),
      ),
    );
    return await compute(_parseLessons, jsonStrings);
  }

  @override
  Future<List<PhrasalVerbs>> getAllPhrasalVerbs() async {
    List<String> topic = [
      "phrasal_verbs_using_around_over_along",
      "phrasal_verbs_using_back_through_with_at_by",
      "phrasal_verbs_using_down_away",
      "phrasal_verbs_using_into_to_about_for",
      "phrasal_verbs_using_off_in",
      "phrasal_verbs_using_on_upon",
      "phrasal_verbs_using_out",
      "phrasal_verbs_using_together_against_apart_others",
      "phrasal_verbs_using_up",
    ];
    List<PhrasalVerbs> phrasalVerbs = [];
    for (var topic in topic) {
      var lessons = await getAllPhrasalVerbsLesson(topic);
      PhrasalVerbs phrasalVerb = PhrasalVerbs(title: topic, lessons: lessons);
      phrasalVerbs.add(phrasalVerb);
    }
    return phrasalVerbs;
  }

  @override
  Future<List<Lesson>> getAllPhrasalVerbsLesson(String topic) async {
    return parsePhrasalVerbsLessons(topic);
  }

  Future<List<Lesson>> parsePhrasalVerbsLessons(String topic) async {
    var phrasal_verbs = {
      "phrasal_verbs_using_around_over_along": 9,
      "phrasal_verbs_using_back_through_with_at_by": 9,
      "phrasal_verbs_using_down_away": 9,
      "phrasal_verbs_using_into_to_about_for": 9,
      "phrasal_verbs_using_off_in": 12,
      "phrasal_verbs_using_on_upon": 9,
      "phrasal_verbs_using_out": 14,
      "phrasal_verbs_using_together_against_apart_others": 10,
      "phrasal_verbs_using_up": 21
    };
    final end = phrasal_verbs[topic] ?? 0;
    final path = 'assets/json/expressions/phrasal_verbs/$topic';
    final jsonStrings = await Future.wait(
      List.generate(
        end + 1,
        (i) => rootBundle.loadString('$path/lesson_$i.json'),
      ),
    );
    return await compute(_parseLessons, jsonStrings);
  }

  @override
  Future<List<LearningCategory>> getAllCollocationsCat() async {
    List<String> topics = [
      "collocations_of_be_place_put_and_more",
      "collocations_of_do_set_go",
      "collocations_of_give_keep_come",
      "collocations_of_make_take_have",
      "collocations_of_pay_run_break_and_more",
      "collocations_with_other_verbs",
      "compound_adverbs",
      "compound_prepositions",
    ];
    List<LearningCategory> collocations = [];
    for (var topic in topics) {
      var lessons = await getAllCollocationsLesson(topic);
      LearningCategory collocationsModel = LearningCategory(
          id: uuid.v4(),
          title: topic,
          lessons: lessons,
          categoryType: CategoryType.collocations);
      collocations.add(collocationsModel);
    }
    return collocations;
  }

  @override
  Future<List<LearningCategory>> getAllEngProverbsCat() async {
    List<String> topics = [
      "behavior_attitude_approach",
      "daily_life",
      "human_relationships",
      "human_traits_qualities",
      "knowledge_wisdom",
      "notions_feelings",
      "outcome_impact",
      "perseverance",
      "qualities",
      "situations_states",
      "social_interaction",
      "society_law_politics",
      "virtue_vice",
      "wealth_success",
    ];

    List<LearningCategory> engProverbs = [];
    for (var topic in topics) {
      var lessons = await getAllEngProverbsLesson(topic);
      LearningCategory engProverbsModel = LearningCategory(
          id: uuid.v4(),
          title: topic,
          lessons: lessons,
          categoryType: CategoryType.engProverbs);
      engProverbs.add(engProverbsModel);
    }
    return engProverbs;
  }

  @override
  Future<List<LearningCategory>> getAllIdiomsCat() async {
    List<String> topics = [
      "amounts",
      "behavior_approach",
      "certainty_possibility",
      "danger",
      "decision_control",
      "describing_people",
      "describing_qualities",
      "difficulty",
      "everyday_life",
      "failure",
      "feelings",
      "influence_involvement",
      "interactions",
      "knowledge_understanding",
      "opinion",
      "perseverance",
      "personality",
      "relationship",
      "society_law_politics",
      "success",
      "time",
      "truth_secrecy_deception",
      "work_money",
    ];
    List<LearningCategory> idioms = [];
    for (var topic in topics) {
      var lessons = await getAllIdiomsLesson(topic);
      LearningCategory idiomsModel = LearningCategory(
        id: uuid.v4(),
        title: topic,
        lessons: lessons,
        categoryType: CategoryType.idioms,
      );
      idioms.add(idiomsModel);
    }
    return idioms;
  }

  @override
  Future<List<LearningCategory>> getAllLevelBasedCat() async {
    List<String> levelBasedNames = [
      "a1_level",
      "a2_level",
      "b1_level",
      "b2_level",
      "c1_level",
      "c2_level",
    ];

    List<LearningCategory> levelBasedList = [];
    for (var levelBased in levelBasedNames) {
      var lessons = await getAllLevelBasedLesson(levelBased);
      LearningCategory levelBasedModel = LearningCategory(
        id: uuid.v4(),
        title: levelBased,
        lessons: lessons,
        categoryType: CategoryType.levelBased,
      );
      levelBasedList.add(levelBasedModel);
    }
    return levelBasedList;
  }

  @override
  Future<List<LearningCategory>> getAllPhrasalVerbsCat() async {
    List<String> topic = [
      "phrasal_verbs_using_around_over_along",
      "phrasal_verbs_using_back_through_with_at_by",
      "phrasal_verbs_using_down_away",
      "phrasal_verbs_using_into_to_about_for",
      "phrasal_verbs_using_off_in",
      "phrasal_verbs_using_on_upon",
      "phrasal_verbs_using_out",
      "phrasal_verbs_using_together_against_apart_others",
      "phrasal_verbs_using_up",
    ];
    // List<PhrasalVerbs> phrasalVerbs = [];
    List<LearningCategory> phrasalVerbs = [];
    for (var topic in topic) {
      var lessons = await getAllPhrasalVerbsLesson(topic);
      LearningCategory phrasalVerb = LearningCategory(
          id: uuid.v4(),
          title: topic,
          lessons: lessons,
          categoryType: CategoryType.phraselVerbs);
      phrasalVerbs.add(phrasalVerb);
    }
    return phrasalVerbs;
  }

  @override
  Future<List<LearningCategory>> getAllTopicsCat() async {
    List<String> topicNames = [
      "agreement_and_disagreement",
      "animals",
      "appearance",
      "art",
      "body",
      "certainty_and_doubt",
      "cinema_and_theater",
      "colors_and_shapes",
      "decision_suggestion_obligation",
      "eating_drinking_and_serving",
      "education",
      "food_and_drink_preparation",
      "food_and_drinks",
      "food_ingredients",
      "health_and_sickness",
      "hobbies_games",
      "land_transportation",
      "literature",
      "music",
      "opinion_and_argument",
      "personal_care",
      "sports",
      "words_related_to_architecture_and_construction",
      "words_related_to_home_and_garden",
      "words_related_to_linguistics",
      "words_related_to_media_and_communication",
      "words_related_to_medical_science",
      "words_related_to_performing_arts"
    ];

    List<LearningCategory> topics = [];
    for (var topic in topicNames) {
      List<Lesson> lessons = await getAllTopicsLesson(topic);
      LearningCategory topicModel = LearningCategory(
        id: uuid.v4(),
        title: topic,
        lessons: lessons,
        categoryType: CategoryType.topic,
      );
      topics.add(topicModel);
    }
    return topics;
  }

  @override
  Future<List<Word>> getAllTopicsWords() async {
    List<LearningCategory> topics = await getAllTopicsCat();
    List<Word> words = [];
    for (var topic in topics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    return words;
  }

  @override
  Future<List<Word>> getAllCollocationsWords() async {
    List<LearningCategory> topics = await getAllCollocationsCat();
    List<Word> words = [];
    for (var topic in topics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    return words;
  }

  @override
  Future<List<Word>> getAllEngProverbsWords() async {
    List<LearningCategory> topics = await getAllEngProverbsCat();
    List<Word> words = [];
    for (var topic in topics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    return words;
  }

  @override
  Future<List<Word>> getAllIdiomsWords() async {
    List<LearningCategory> topics = await getAllIdiomsCat();
    List<Word> words = [];
    for (var topic in topics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    return words;
  }

  @override
  Future<List<Word>> getAllLevelBasedWords() async {
    List<LearningCategory> topics = await getAllLevelBasedCat();
    List<Word> words = [];
    for (var topic in topics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    return words;
  }

  @override
  Future<List<Word>> getAllPhrasalVerbsWords() async {
    List<LearningCategory> topics = await getAllPhrasalVerbsCat();
    List<Word> words = [];
    for (var topic in topics) {
      for (var lesson in topic.lessons!) {
        words = [...words, ...lesson.wordList!];
      }
    }
    return words;
  }
}
