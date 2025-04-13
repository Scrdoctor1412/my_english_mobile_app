import 'package:englens/src/data/data_sources/assets_data.dart';
import 'package:englens/src/data/data_sources/local_data.dart';
import 'package:englens/src/data/models/topic.dart';
import 'package:get/get.dart';

abstract interface class TopicsRepository {
  Future<void> initData();

  List<Topic> getAllTopics();
}

class TopicsRepositoryImpl extends GetxController implements TopicsRepository {
  final AssetsData _assetsData;
  final LocalData _localData;

  TopicsRepositoryImpl({
    required AssetsData assetsData,
    required LocalData localData,
  })  : _assetsData = assetsData,
        _localData = localData;

  @override
  List<Topic> getAllTopics() {
    // TODO: implement getAllTopics
    return _localData.getTopics();
  }

  @override
  Future<void> initData() async {
    // TODO: implement initData
    final currentTopics = _localData.getTopics();
    if (currentTopics.isNotEmpty) return;
    final topics = await _assetsData.getAllTopics();
    await _localData.saveTopics(topics);
  }
}
