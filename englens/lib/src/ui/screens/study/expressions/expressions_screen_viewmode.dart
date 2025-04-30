import 'package:englens/src/core/base_view_model.dart';
import 'package:englens/src/ui/screens/study/expressions/collocations/collocations_screen.dart';
import 'package:englens/src/ui/screens/study/expressions/eng_proverbs/eng_proverbs_screen.dart';
import 'package:englens/src/ui/screens/study/expressions/idioms/idioms_screen.dart';
import 'package:englens/src/ui/screens/study/expressions/phrasal_verbs/phrasal_verbs_screen.dart';

class ExpressionsScreenViewModel extends GetViewModelBase {
  List<String> expressionsSection = [
    "Idioms",
    "Collocations",
    "English Proverbs",
    "Phrasal verbs",
  ];
  List<String> vocabularySectionScreenName = [
    IdiomsScreen.routeName,
    CollocationsScreen.routeName,
    EngProverbsScreen.routeName,
    PhrasalVerbsScreen.routeName,
  ];
}
