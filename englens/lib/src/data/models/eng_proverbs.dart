import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive/hive.dart';

part 'generated/eng_proverbs.g.dart';

@HiveType(typeId: HiveTypes.engProverbs)
class EngProverbs {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;
  EngProverbs({
    required this.title,
    required this.lessons,
  });
  factory EngProverbs.fromJson(Map<String, dynamic> json) {
    return EngProverbs(
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
