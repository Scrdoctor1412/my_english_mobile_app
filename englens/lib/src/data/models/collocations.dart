import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive/hive.dart';

part 'generated/collocations.g.dart';

@HiveType(typeId: HiveTypes.collocations)
class Collocations {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;
  Collocations({
    required this.title,
    required this.lessons,
  });
  factory Collocations.fromJson(Map<String, dynamic> json) {
    return Collocations(
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
