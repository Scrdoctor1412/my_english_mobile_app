import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// Đảm bảo các import này trỏ đúng tới model trong source code của bạn
import 'package:englens/src/data/models/learning_category.dart';
import 'package:englens/src/data/models/lesson.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/data/models/sense.dart';
import 'package:englens/src/data/models/example.dart';

void main() async {
  print('===================================================');
  print('🚀 BẮT ĐẦU CHUYỂN ĐỔI JSON SANG HIVE DATABASE 🚀');
  print('===================================================\n');

  final currentPath = Directory.current.path;
  final outputDir = Directory('${currentPath}assets/db');

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // 1. Khởi tạo Hive cho Desktop
  Hive.init(outputDir.path);

  // 2. Register Adapters
  Hive.registerAdapter(LearningCategoryAdapter());
  Hive.registerAdapter(LessonAdapter());
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(SenseAdapter());
  Hive.registerAdapter(ExampleAdapter());
  Hive.registerAdapter(CategoryTypeAdapter()); // Enum CategoryType

  // 3. Mở Box
  var wordBox = await Hive.openBox<Word>('word');
  var categoryBox = await Hive.openBox<LearningCategory>('learningCategory');

  // --- 4. BẮT ĐẦU XỬ LÝ TỪNG PHÂN MỤC ---

  // 4.1. Oxford Words (Nằm riêng biệt, không có Category)
  await _processOxfordWords(currentPath, wordBox);

  // 4.2. Các Category tiêu chuẩn (Topic, Level, Idiom, v.v...)
  await _processStandardCategory(
    basePath: '$currentPath/assets/json/topics_words',
    categoryMap: _topicCase,
    type: CategoryType.topic,
    categoryBox: categoryBox,
    wordBox: wordBox,
  );

  await _processStandardCategory(
    basePath: '$currentPath/assets/json/wordlist_by_level_words',
    categoryMap: _levelBasedCase,
    type: CategoryType.levelBased,
    categoryBox: categoryBox,
    wordBox: wordBox,
  );

  await _processStandardCategory(
    basePath: '$currentPath/assets/json/expressions/collocations',
    categoryMap: _collocationsCase,
    type: CategoryType.collocations,
    categoryBox: categoryBox,
    wordBox: wordBox,
  );

  await _processStandardCategory(
    basePath: '$currentPath/assets/json/expressions/eng_proverbs',
    categoryMap: _engProverbsCase,
    type: CategoryType.engProverbs,
    categoryBox: categoryBox,
    wordBox: wordBox,
  );

  await _processStandardCategory(
    basePath: '$currentPath/assets/json/expressions/idioms',
    categoryMap: _idiomsCase,
    type: CategoryType.idioms,
    categoryBox: categoryBox,
    wordBox: wordBox,
  );

  await _processStandardCategory(
    basePath: '$currentPath/assets/json/expressions/phrasal_verbs',
    categoryMap: _phrasalVerbsCase,
    type: CategoryType
        .phraselVerbs, // Chú ý: viết theo đúng enum cũ của bạn là phraselVerbs
    categoryBox: categoryBox,
    wordBox: wordBox,
  );

  // 5. ĐÓNG BOX (Bắt buộc để lưu file)
  await wordBox.close();
  await categoryBox.close();

  print('\n===================================================');
  print('🎉 HOÀN TẤT! ĐÃ LƯU THÀNH CÔNG VÀO assets/db/');
  print('===================================================');
}

// =====================================================================
// HÀM XỬ LÝ CHUNG CHO CÁC MỤC (TOPICS, LEVEL, IDIOMS, COLLOCATIONS...)
// =====================================================================
Future<void> _processStandardCategory({
  required String basePath,
  required Map<String, int> categoryMap,
  required CategoryType type,
  required Box<LearningCategory> categoryBox,
  required Box<Word> wordBox,
}) async {
  print('⏳ Đang xử lý thể loại: ${type.toString().split('.').last}...');
  var uuid = const Uuid();

  for (var entry in categoryMap.entries) {
    String topicName = entry.key;
    int end = entry.value;
    List<Lesson> lessons = [];

    for (int i = 0; i <= end; i++) {
      final file = File('$basePath/$topicName/lesson_$i.json');

      if (file.existsSync()) {
        final jsonString = await file.readAsString();
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

        final lesson = Lesson.fromJson(jsonMap);
        lessons.add(lesson);

        // Ném từ vựng thẳng vào bảng Words luôn
        if (lesson.wordList != null) {
          for (var word in lesson.wordList!) {
            await wordBox.put(word.id, word);
          }
        }
      }
    }

    LearningCategory catModel = LearningCategory(
      id: uuid.v4(),
      title: topicName,
      lessons: lessons,
      categoryType: type,
    );

    await categoryBox.put(catModel.id, catModel);
  }
  print('✔️ Hoàn thành: ${type.toString().split('.').last}');
}

// =====================================================================
// HÀM XỬ LÝ RIÊNG CHO OXFORD WORDS (Vì cấu trúc JSON khác biệt)
// =====================================================================
Future<void> _processOxfordWords(String currentPath, Box<Word> wordBox) async {
  print('⏳ Đang xử lý: Oxford Words...');
  final List<String> letters = 'abcdefghijklmnopqrstuvwxyz'.split('');

  for (final letter in letters) {
    final file = File('$currentPath/assets/json/oxford_words/$letter.json');
    if (file.existsSync()) {
      final jsonString = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonString);

      for (var jsonMap in jsonList) {
        var word = Word.fromJson(jsonMap);
        await wordBox.put(word.id, word);
      }
    }
  }
  print('✔️ Hoàn thành: Oxford Words');
}

// =====================================================================
// CÁC DICTIONARY CHỨA CẤU TRÚC THƯ MỤC CỦA BẠN
// =====================================================================

const _topicCase = {
  "agreement_and_disagreement": 16,
  "animals": 54,
  "appearance": 17,
  "art": 26,
  "body": 18,
  "certainty_and_doubt": 8,
  "cinema_and_theater": 15,
  "colors_and_shapes": 21,
  "decision_suggestion_obligation": 18,
  "eating_drinking_and_serving": 11,
  "education": 42,
  "food_and_drink_preparation": 17,
  "food_and_drinks": 40,
  "food_ingredients": 28,
  "health_and_sickness": 21,
  "hobbies_games": 27,
  "land_transportation": 37,
  "literature": 18,
  "music": 29,
  "opinion_and_argument": 10,
  "personal_care": 15,
  "sports": 62,
  "words_related_to_architecture_and_construction": 37,
  "words_related_to_home_and_garden": 26,
  "words_related_to_linguistics": 23,
  "words_related_to_media_and_communication": 28,
  "words_related_to_medical_science": 27,
  "words_related_to_performing_arts": 15,
};

const _levelBasedCase = {
  'a1_level': 31,
  'a2_level': 49,
  'b1_level': 57,
  'b2_level': 63,
  'c1_level': 66,
  'c2_level': 88,
};

const _collocationsCase = {
  "collocations_of_be_place_put_and_more": 6,
  "collocations_of_do_set_go": 6,
  "collocations_of_give_keep_come": 5,
  "collocations_of_make_take_have": 9,
  "collocations_of_pay_run_break_and_more": 4,
  "collocations_with_other_verbs": 7,
  "compound_adverbs": 8,
  "compound_prepositions": 10,
};

const _engProverbsCase = {
  "behavior_attitude_approach": 17,
  "daily_life": 6,
  "human_relationships": 6,
  "human_traits_qualities": 9,
  "knowledge_wisdom": 10,
  "notions_feelings": 9,
  "outcome_impact": 6,
  "perseverance": 8,
  "qualities": 10,
  "situations_states": 9,
  "social_interaction": 8,
  "society_law_politics": 7,
  "virtue_vice": 6,
  "wealth_success": 9,
};

const _idiomsCase = {
  "amounts": 6,
  "behavior_approach": 16,
  "certainty_possibility": 10,
  "danger": 8,
  "decision_control": 9,
  "describing_people": 9,
  "describing_qualities": 15,
  "difficulty": 10,
  "everyday_life": 12,
  "failure": 10,
  "feelings": 11,
  "influence_involvement": 11,
  "interactions": 12,
  "knowledge_understanding": 12,
  "opinion": 10,
  "perseverance": 8,
  "personality": 11,
  "relationship": 8,
  "society_law_politics": 11,
  "success": 11,
  "time": 10,
  "truth_secrecy_deception": 10,
  "work_money": 11,
};

const _phrasalVerbsCase = {
  "phrasal_verbs_using_around_over_along": 9,
  "phrasal_verbs_using_back_through_with_at_by": 9,
  "phrasal_verbs_using_down_away": 9,
  "phrasal_verbs_using_into_to_about_for": 9,
  "phrasal_verbs_using_off_in": 12,
  "phrasal_verbs_using_on_upon": 9,
  "phrasal_verbs_using_out": 14,
  "phrasal_verbs_using_together_against_apart_others": 10,
  "phrasal_verbs_using_up": 21,
};
