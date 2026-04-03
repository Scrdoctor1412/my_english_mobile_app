import 'package:dartz/dartz.dart';
import 'package:englens/src/core/failure.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:get/get.dart';

abstract interface class OxfordWordsRepository {
  Future<void> initData();
  List<Word> getAllOxfordWords();
  Future<Either<Failure, void>> saveWord(Word word);
}

class OxfordWordsRepositoryImpl extends GetxController
    implements OxfordWordsRepository {
  final LocalData _localData;

  OxfordWordsRepositoryImpl({required LocalData localData})
    : _localData = localData;

  @override
  Future<void> initData() async {
    // Không làm gì cả, Oxford Words đã được nạp sẵn vào box 'word'
  }

  @override
  List<Word> getAllOxfordWords() {
    // Giả sử bạn muốn lấy toàn bộ, hoặc có thể filter theo thuộc tính nào đó của Oxford
    return _localData.getWords();
  }

  @override
  Future<Either<Failure, void>> saveWord(Word word) async {
    try {
      await _localData.saveWord(word);
      return right(null);
    } catch (e) {
      return left(Failure());
    }
  }
}
