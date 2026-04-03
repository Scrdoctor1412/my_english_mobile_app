import 'package:hive/hive.dart';

import 'package:englens/src/core/configs/hive/hive_types.dart';

part 'generated/leitner_box.g.dart'; // Dùng build_runner để generate

@HiveType(typeId: HiveTypes.leitnerBoxType)
enum LeitnerBoxType {
  @HiveField(0)
  pending,
  @HiveField(1)
  everyDay,
  @HiveField(2)
  every2days,
  @HiveField(3)
  every4days,
  @HiveField(4)
  every8days,
  @HiveField(5)
  every16days,
  @HiveField(6)
  every32days,
  @HiveField(7)
  learned,
}

@HiveType(typeId: HiveTypes.leitnerBox)
class LeitnerBox {
  @HiveField(0)
  int? index;

  @HiveField(1)
  LeitnerBoxType? boxType;

  @HiveField(2)
  List<String>? wordIds;

  @HiveField(3)
  String? lastLearned;

  LeitnerBox({this.index, this.boxType, this.wordIds, this.lastLearned});

  LeitnerBox copyWith({
    int? index,
    LeitnerBoxType? boxType,
    List<String>? wordIds,
    String? lastLearned,
  }) {
    return LeitnerBox(
      index: index ?? this.index,
      boxType: boxType ?? this.boxType,
      wordIds: wordIds ?? List<String>.from(this.wordIds ?? []),
      lastLearned: lastLearned ?? this.lastLearned,
    );
  }
}
