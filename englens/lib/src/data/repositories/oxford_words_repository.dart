import 'package:dartz/dartz.dart';
import 'package:englens/src/core/failure.dart';
import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/utils/extensions/list_extensions.dart';
import 'package:get/get.dart';

abstract interface class OxfordWordsRepository {
  Future<void> initData();

  List<Word> getAllOxfordWords();

  Future<Either<Failure, void>> saveWord(Word word);
}

class OxfordWordsRepositoryImpl extends GetxController
    implements OxfordWordsRepository {
  final AssetsData _assetsData;
  final LocalData _localData;

  OxfordWordsRepositoryImpl({
    required AssetsData assetsData,
    required LocalData localData,
  })  : _assetsData = assetsData,
        _localData = localData;

  @override
  Future<void> initData() async {
    final currentWords = _localData.getWords();
    if (currentWords.isNotEmpty) return;
    final words = (await _assetsData.getAllOxfordWords()).mapIndexed(
      (index, word) {
        word.index = index + 1;
        return word;
      },
    ).toList();
    await _localData.saveWords(words);
  }

  @override
  List<Word> getAllOxfordWords() => _localData.getWords();

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
