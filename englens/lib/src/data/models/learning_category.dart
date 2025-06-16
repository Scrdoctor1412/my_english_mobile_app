// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:englens/src/configs/hive/hive_types.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'generated/learning_category.g.dart';

@HiveType(typeId: HiveTypes.categoryType)
enum CategoryType {
  @HiveField(0)
  idioms,
  @HiveField(1)
  collocations,
  @HiveField(2)
  phraselVerbs,
  @HiveField(3)
  engProverbs,
  @HiveField(4)
  topic,
  @HiveField(5)
  levelBased
}

@HiveType(typeId: HiveTypes.learningCategory)
class LearningCategory {
  @HiveField(0)
  final String title;

  @HiveField(1)
  List<Lesson>? lessons;

  @HiveField(2)
  bool? isBookmarked;

  @HiveField(3)
  CategoryType? categoryType;

  @HiveField(4)
  String id;

  LearningCategory({
    required this.title,
    this.lessons,
    this.isBookmarked,
    this.categoryType,
    required this.id,
  });

  factory LearningCategory.fromJson(Map<String, dynamic> json) {
    return LearningCategory(
      title: json['title'],
      lessons:
          List<Lesson>.from(json['lessons'].map((x) => Lesson.fromJson(x))),
      isBookmarked: json['isBookmarked'] ?? false,
      categoryType: json['categoryType'],
      id: json['id'] ?? "",
    );
  }
}
