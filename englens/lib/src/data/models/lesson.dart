import 'package:englens/src/core/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/lesson.g.dart';

@HiveType(typeId: HiveTypes.lesson)
class Lesson {
  @HiveField(0)
  final String topic;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String lesson;

  @HiveField(3)
  List<Word>? wordList;

  @HiveField(4)
  String? id;

  @HiveField(5)
  bool? isBookmarked;

  Lesson({
    required this.topic,
    required this.title,
    required this.lesson,
    this.wordList,
    this.id,
    this.isBookmarked,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    // final rawList = json['word_list'] as List<dynamic>?;
    // final words = rawList?.map((item) {
    //   print('Decoding word: $item'); // Log từng phần tử
    //   return Word.fromJson(item as Map<String, dynamic>);
    // }).toList();

    return Lesson(
      topic: json['topic'] ?? "",
      title: json['title'] ?? "",
      lesson: json['lesson'] ?? "",
      wordList: (json['word_list'] as List<dynamic>)
          .map((lesWordList) => Word.fromJson(lesWordList))
          .toList(),
      id: json['id'] ?? "",
      isBookmarked: json['is_bookmarked'] ?? false,
      // wordList: words
      // wordList: );
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'title': title,
      'lesson': lesson,
      'word_list': wordList?.map((word) => word.toJson()).toList(),
      'id': id,
      'is_bookmarked': isBookmarked,
    };
  }
}
