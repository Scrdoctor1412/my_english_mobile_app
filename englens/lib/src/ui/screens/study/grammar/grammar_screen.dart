import 'package:englens/src/ui/screens/study/grammar/grammar_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class GrammarScreen extends StatelessWidget {
  static const routeName = '/grammarScreen';

  const GrammarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrammarScreenViewmodel>(
      init: GrammarScreenViewmodel(),
      builder: (controller) {
        _body() {
          return Center(
            child: Text('Hi grammar'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
