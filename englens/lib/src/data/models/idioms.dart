import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive/hive.dart';

part 'generated/idioms.g.dart';

@HiveType(typeId: HiveTypes.idioms)
class Idioms {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;
  Idioms({
    required this.title,
    required this.lessons,
  });
  factory Idioms.fromJson(Map<String, dynamic> json) {
    return Idioms(
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
