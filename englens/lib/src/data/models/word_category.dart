// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:englens/src/data/models/lesson.dart';

// enum WordCategoryType {
//   topics,
//   level,
//   collocation,
//   idioms,
//   engProverbs,
//   phrasalVerbs
// }

// class WordCategory {
//   final WordCategoryType? listWordType;

//   final WordCategoryList? wordCategoryList;
//   WordCategory({
//     this.listWordType,
//     this.wordCategoryList,
//   });
// }

// class WordCategoryList {
//   final String title;
//   List<Lesson>? lessons;

//   WordCategoryList({required this.title, this.lessons});

//   factory WordCategoryList.fromJson(Map<String, dynamic> json) {
//     return WordCategoryList(
//       title: json["title"] ?? "",
//       lessons: (json['lessons'] as List<dynamic>)
//           .map((lesson) => Lesson.fromJson(lesson))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       "title": title,
//       "lessons": lessons?.map((lesson) => lesson.toJson()).toList(),
//     };
//   }

//   String toJson() => json.encode(toMap());
// }
