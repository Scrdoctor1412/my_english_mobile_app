import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/data/repositories/expressions_repository.dart';
import 'package:englens/src/ui/screens/study/expressions/collocations/collocations_screen.dart';
import 'package:englens/src/ui/screens/study/expressions/eng_proverbs/eng_proverbs_screen.dart';
import 'package:englens/src/ui/screens/study/expressions/idioms/idioms_screen.dart';
import 'package:englens/src/ui/screens/study/expressions/phrasal_verbs/phrasal_verbs_screen.dart';
import 'package:get/get.dart';

class ExpressionsScreenViewModel extends GetViewModelBase {
  final _expressionRepo = Get.find<ExpressionsRepositoryImpl>();
  List<String> expressionsSection = [
    "Idioms",
    "Collocations",
    "English Proverbs",
    "Phrasal verbs",
  ];
  List<int> expressionsSectionTopicsCount = [];
  List<String> vocabularySectionScreenName = [
    IdiomsScreen.routeName,
    CollocationsScreen.routeName,
    EngProverbsScreen.routeName,
    PhrasalVerbsScreen.routeName,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    expressionsSectionTopicsCount.add(_expressionRepo.getAllIdioms().length);
    expressionsSectionTopicsCount
        .add(_expressionRepo.getAllCollocations().length);
    expressionsSectionTopicsCount
        .add(_expressionRepo.getAllEngProverbs().length);
    expressionsSectionTopicsCount
        .add(_expressionRepo.getAllPhrasalverbs().length);
  }
}
