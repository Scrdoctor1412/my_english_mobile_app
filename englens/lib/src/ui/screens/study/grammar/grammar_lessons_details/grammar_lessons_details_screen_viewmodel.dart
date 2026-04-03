import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/core/utils/helper.dart';
import 'package:get/get.dart';

class GrammarLessonsDetailsScreenArgs {
  final String asssetLink;
  final String? title;
  GrammarLessonsDetailsScreenArgs({required this.asssetLink, this.title});
}

class GrammarLessonsDetailsScreenViewmodel extends GetViewModelBase {
  late String assetLink;
  String? assetsData;
  String? title;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      GrammarLessonsDetailsScreenArgs args = Get.arguments;
      assetLink = args.asssetLink;
      title = args.title;
    }

    initData();
  }

  void initData() async {
    assetsData = await loadAssets(assetLink);
    update();
  }
}
