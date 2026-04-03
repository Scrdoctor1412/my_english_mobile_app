import 'package:englens/src/data/models/learning_record.dart';
import 'package:englens/src/data/repositories/learning_record_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LearningRecordService {
  static final LearningRecordRepositoryImpl _leitnerBoxRepositoryImpl =
      Get.find<LearningRecordRepositoryImpl>();

  static Future<void> initData() async {
    await _leitnerBoxRepositoryImpl.initData();
    List<LearningRecord> learningRecords =
        _leitnerBoxRepositoryImpl.getLearningRecords();
    var formatter = DateFormat("dd/MM/yyyy");
    //Khởi tạo records cho ngày mới
    if (learningRecords.isEmpty) {
      //Nếu record đang rỗng -> thêm mới
      learningRecords.add(LearningRecord(
        id: formatter.format(DateTime.now()),
        wordIds: [],
        learnDate: formatter.format(DateTime.now()),
      ));
    } else {
      String now = formatter.format(DateTime.now());
      int indexDuplicate = learningRecords.indexWhere(
        (element) => element.id == now,
      );
      if (indexDuplicate == -1) {
        learningRecords.add(LearningRecord(
          id: formatter.format(DateTime.now()),
          wordIds: [],
          learnDate: formatter.format(DateTime.now()),
        ));
      }
    }
    await saveRecords(learningRecords);
  }

  static Future<void> saveRecords(List<LearningRecord> learningRecords) async {
    await _leitnerBoxRepositoryImpl.saveRecords(learningRecords);
  }

  static Future<void> updateRecord(LearningRecord learningRecords) async {
    await _leitnerBoxRepositoryImpl.updateRecord(learningRecords);
  }

  static List<LearningRecord> getLearningRecords() {
    return _leitnerBoxRepositoryImpl.getLearningRecords();
  }
}
