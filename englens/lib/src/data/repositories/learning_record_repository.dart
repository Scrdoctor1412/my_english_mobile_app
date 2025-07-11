import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/learning_record.dart';
import 'package:get/get.dart';

abstract interface class LearningRecordRepository {
  Future<void> initData();

  Future<void> saveRecords(List<LearningRecord> learningRecords);

  Future<void> updateRecord(LearningRecord learningRecords);

  List<LearningRecord> getLearningRecords();
}

class LearningRecordRepositoryImpl extends GetxController
    implements LearningRecordRepository {
  final LocalData _localData;
  LearningRecordRepositoryImpl({
    required LocalData localData,
  }) : _localData = localData;

  @override
  Future<void> initData() async {
    List<LearningRecord> currentRecords = _localData.getLearningRecords();
    if (currentRecords.isNotEmpty) return;
    List<LearningRecord> learningRecords = [];
    await saveRecords(learningRecords);
  }

  @override
  List<LearningRecord> getLearningRecords() {
    return _localData.getLearningRecords();
  }

  @override
  Future<void> saveRecords(List<LearningRecord> learningRecords) async {
    await _localData.saveRecords(learningRecords);
  }

  @override
  Future<void> updateRecord(LearningRecord learningRecords) async {
    await _localData.updateRecord(learningRecords);
  }
}
