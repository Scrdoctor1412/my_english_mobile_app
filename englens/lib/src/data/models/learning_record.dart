import 'package:englens/src/core/configs/hive/hive_types.dart';
import 'package:hive/hive.dart';

part 'generated/learning_record.g.dart';

@HiveType(typeId: HiveTypes.learningRecord)
class LearningRecord {
  @HiveField(0)
  String? id;

  @HiveField(1)
  List<String>? wordIds;

  @HiveField(2)
  String? learnDate;

  LearningRecord({this.id, this.wordIds, this.learnDate});
}
