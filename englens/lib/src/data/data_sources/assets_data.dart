import 'dart:convert';

import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract interface class AssetsData extends GetxController {
  Future<List<Word>> getOxfordWordsByLetter(String letter);
  Future<List<Word>> getAllOxfordWords();
  Future<List<Lesson>> getAllTopicsLesson(String topic);
  Future<List<Topic>> getAllTopics();
}

class AssetsDataImpl extends GetxController implements AssetsData {
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
    return await parseLessons(topic);
  }

  Future<List<Lesson>> parseLessons(String topic) async {
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
}
