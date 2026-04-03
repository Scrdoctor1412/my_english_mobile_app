import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/learning_record.dart';
import 'package:englens/src/core/service/learning_record_service.dart';

class ProgressChartScreenViewmodel extends GetViewModelBase {
  List<LearningRecord> learningRecords = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
    update();
  }

  void initData() {
    learningRecords = LearningRecordService.getLearningRecords();
    learningRecords = learningRecords.reversed.toList();
  }
}
