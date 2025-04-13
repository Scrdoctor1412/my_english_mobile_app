import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive/hive.dart';

part 'generated/topic.g.dart';

@HiveType(typeId: HiveTypes.topic)
class Topic {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;
  Topic({
    required this.title,
    required this.lessons,
  });
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'] ?? "",
      lessons: (json['lessons'] as List<dynamic>)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'lessons': lessons?.map((lesson) => lesson.toJson()).toList(),
    };
  }
}
