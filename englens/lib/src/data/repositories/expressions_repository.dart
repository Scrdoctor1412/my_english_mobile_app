import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/collocations.dart';
import 'package:englens/src/data/models/eng_proverbs.dart';
import 'package:englens/src/data/models/idioms.dart';
import 'package:englens/src/data/models/phrasal_verbs.dart';
import 'package:get/get.dart';

abstract interface class ExpressionsRepository {
  Future<void> initData();

  Future<void> initIdioms();
  Future<void> initCollocations();
  Future<void> initEngProverbs();
  Future<void> initPhrasalverbs();

  List<Idioms> getAllIdioms();
  List<Collocations> getAllCollocations();
  List<EngProverbs> getAllEngProverbs();
  List<PhrasalVerbs> getAllPhrasalverbs();
}

class ExpressionsRepositoryImpl extends GetxController
    implements ExpressionsRepository {
  final AssetsData _assetsData;
  final LocalData _localData;

  ExpressionsRepositoryImpl({
    required AssetsData assetsData,
    required LocalData localData,
  })  : _assetsData = assetsData,
        _localData = localData;

  @override
  Future<void> initData() async {
    // await Future.wait([
    //   initCollocations(),
    //   initEngProverbs(),
    //   initIdioms(),
    //   initPhrasalverbs(),
    // ]);
    await initCollocations();
    await initEngProverbs();
    await initIdioms();
    await initPhrasalverbs();
  }

  @override
  Future<void> initCollocations() async {
    final currentCollocations = _localData.getCollocations();
    if (currentCollocations.isNotEmpty) return;
    final collocations = await _assetsData.getAllCollocations();
    await _localData.saveCollocations(collocations);
  }

  @override
  Future<void> initEngProverbs() async {
    final currentEngProverbs = _localData.getEngProverbs();
    if (currentEngProverbs.isNotEmpty) return;
    final engProverbs = await _assetsData.getAllEngProverbs();
    _localData.saveEngProverbs(engProverbs);
  }

  @override
  Future<void> initIdioms() async {
    final currentIdioms = _localData.getIdioms();
    if (currentIdioms.isNotEmpty) return;
    final idioms = await _assetsData.getAllIdioms();
    _localData.saveIdioms(idioms);
  }

  @override
  Future<void> initPhrasalverbs() async {
    final currentPhrasalverbs = _localData.getPhrasalVerbs();
    if (currentPhrasalverbs.isNotEmpty) return;
    final phrasalverbs = await _assetsData.getAllPhrasalVerbs();
    _localData.savePhrasalVerbs(phrasalverbs);
  }

  @override
  List<Collocations> getAllCollocations() {
    return _localData.getCollocations();
  }

  @override
  List<EngProverbs> getAllEngProverbs() {
    return _localData.getEngProverbs();
  }

  @override
  List<Idioms> getAllIdioms() {
    return _localData.getIdioms();
  }

  @override
  List<PhrasalVerbs> getAllPhrasalverbs() {
    return _localData.getPhrasalVerbs();
  }
}
