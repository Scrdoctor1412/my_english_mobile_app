import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/level_based.g.dart';

@HiveType(typeId: HiveTypes.levelBased)
class LevelBased {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;

  LevelBased({required this.title, required this.lessons});

  factory LevelBased.fromJson(Map<String, dynamic> json) {
    return LevelBased(
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
