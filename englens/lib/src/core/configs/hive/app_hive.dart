import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Đảm bảo import đúng các model của bạn
import 'package:englens/src/data/models/example.dart';
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/learning_record.dart';
import 'package:englens/src/data/models/leitner_box.dart';
import 'package:englens/src/data/models/schedule_notification.dart';
import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/data/models/word.dart';

class AppHive {
  static const String wordKey = 'word';
  static const String learningCategoryKey = 'learningCategory';
  static const String scheduleNotificationKey = 'scheduledNotification';
  static const String leitnerBoxKey = 'leitnerBox';
  static const String learningRecordBoxKey = "learningRecordBox";

  Box<Word> get wordBox => Hive.box<Word>(wordKey);
  Box<LearningCategory> get learningCategoryBox =>
      Hive.box<LearningCategory>(learningCategoryKey);
  Box<ScheduleNotification> get scheduleNotificationBox =>
      Hive.box<ScheduleNotification>(scheduleNotificationKey);
  Box<LeitnerBox> get leitnerBoxBox => Hive.box<LeitnerBox>(leitnerBoxKey);
  Box<LearningRecord> get learningRecordBox =>
      Hive.box<LearningRecord>(learningRecordBoxKey);

  Future<void> init() async {
    // Sử dụng Documents Directory để dữ liệu không bị OS tự động xóa
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);

    // Đăng ký toàn bộ Adapters
    Hive.registerAdapter(LearningCategoryAdapter());
    Hive.registerAdapter(LeitnerBoxAdapter());
    Hive.registerAdapter(LeitnerBoxTypeAdapter());
    Hive.registerAdapter(ExampleAdapter());
    Hive.registerAdapter(SenseAdapter());
    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(ScheduleNotificationAdapter());
    Hive.registerAdapter(LessonAdapter());
    Hive.registerAdapter(CategoryTypeAdapter());
    Hive.registerAdapter(LearningRecordAdapter());

    // COPY FILE TỪ ASSETS VÀO BỘ NHỚ TRONG (Chỉ chạy khi chưa có file)
    await _copyPrePopulatedBox(dir.path, wordKey);
    await _copyPrePopulatedBox(dir.path, learningCategoryKey);

    // Mở các Box chứa dữ liệu tĩnh (đã được copy ở trên)
    await Hive.openBox<Word>(wordKey);
    await Hive.openBox<LearningCategory>(learningCategoryKey);

    // Mở các Box chứa dữ liệu động của User
    await Hive.openBox<ScheduleNotification>(scheduleNotificationKey);
    await Hive.openBox<LeitnerBox>(leitnerBoxKey);
    await Hive.openBox<LearningRecord>(learningRecordBoxKey);
  }

  // Hàm xử lý copy file nhị phân
  Future<void> _copyPrePopulatedBox(String dirPath, String boxName) async {
    // Bắt buộc chuyển tên thành chữ thường để Hive nhận diện đúng file
    final fileName = '${boxName.toLowerCase()}.hive';
    final file = File('$dirPath/$fileName');

    if (!await file.exists()) {
      try {
        ByteData data = await rootBundle.load('assets/db/$fileName');
        List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );
        await file.writeAsBytes(bytes);
        print('Copy thành công box: $fileName');
      } catch (e) {
        print('Lỗi copy box $boxName: $e');
      }
    }
  }
}
