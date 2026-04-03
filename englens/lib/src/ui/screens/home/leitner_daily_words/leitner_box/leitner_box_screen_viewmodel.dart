import 'package:englens/src/core/constants/app_constants.dart';
import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/models/leitner_box.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/core/service/leitner_box_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeitnerBoxScreenArgs {
  final String title;
  final int? boxIndex;
  final List<Word> wordList;
  final LeitnerBoxType leitnerBoxType;

  LeitnerBoxScreenArgs({
    required this.title,
    this.boxIndex,
    required this.wordList,
    required this.leitnerBoxType,
  });
}

class LeitnerBoxScreenViewmodel extends GetViewModelBase {
  late SharedPreferences prefs;
  String title = "";
  int? boxIndex;
  List<Word> wordList = [];
  LeitnerBoxType leitnerBoxType = LeitnerBoxType.pending;

  String countDownDayText = "today";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      LeitnerBoxScreenArgs args = Get.arguments as LeitnerBoxScreenArgs;
      title = args.title;
      boxIndex = args.boxIndex;
      wordList = args.wordList;
      leitnerBoxType = args.leitnerBoxType;
    }
    onChangeCountDownDayText(leitnerBoxType);
    initData();
  }

  void initData() async {
    prefs = await SharedPreferences.getInstance();
  }

  void onTapDeleteWordFromLeitnerBox(int index) {
    var leitnerBoxes = LeitnerBoxService.getLeitnerBoxes();
    leitnerBoxes[boxIndex!].wordIds!.removeAt(index);
    LeitnerBoxService.saveLeitnerBoxes(leitnerBoxes);
    //xóa khỏi preferences
    var listPrefs = prefs.getStringList(AppConstants.leitnerBoxPrefsKey) ?? [];
    if (listPrefs.isNotEmpty) {
      var indexDuplicate = listPrefs.indexWhere(
        (element) => element == wordList[index].id,
      );
      // listPrefs.removeWhere((element) => element == wordList[index].id);
      if (indexDuplicate != -1) {
        listPrefs.removeAt(indexDuplicate);
      }
    }

    prefs.setStringList(AppConstants.leitnerBoxPrefsKey, listPrefs);
    wordList.removeAt(index);
    update();
  }

  void onChangeCountDownDayText(LeitnerBoxType leitnerBoxType) {
    switch (leitnerBoxType) {
      // case LeitnerBoxType.learned:
      //   countDownDayText = "today";
      //   break;
      case LeitnerBoxType.every2days:
        countDownDayText = "2 days";
        break;
      case LeitnerBoxType.every4days:
        countDownDayText = "4 days";
        break;
      case LeitnerBoxType.every8days:
        countDownDayText = "8 days";
        break;
      case LeitnerBoxType.every16days:
        countDownDayText = "16 days";
        break;
      case LeitnerBoxType.every32days:
        countDownDayText = "32 days";
        break;
      default:
        countDownDayText = "today";
        break;
    }
    update();
  }
}
