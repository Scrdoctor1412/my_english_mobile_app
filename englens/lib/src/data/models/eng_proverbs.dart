import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/book.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive/hive.dart';

part 'generated/eng_proverbs.g.dart';

@HiveType(typeId: HiveTypes.engProverbs)
class EngProverbs extends Book {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;

  @HiveField(2)
  String? id;

  @HiveField(3)
  bool? isBookmarked;

  EngProverbs(
      {required this.title, required this.lessons, this.id, this.isBookmarked});
  factory EngProverbs.fromJson(Map<String, dynamic> json) {
    return EngProverbs(
      title: json['title'] ?? "",
      lessons: (json['lessons'] as List<dynamic>)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
      id: json["id"] ?? "",
      isBookmarked: json["is_bookmarked"] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'lessons': lessons?.map((lesson) => lesson.toJson()).toList(),
      'id': id,
      'isBookmarked': isBookmarked,
    };
  }
}
