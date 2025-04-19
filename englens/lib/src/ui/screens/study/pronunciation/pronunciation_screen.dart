import 'package:englens/src/ui/screens/study/pronunciation/pronunciation_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PronunciationScreen extends StatelessWidget {
  static const routeName = '/pronunciationScreen';
  const PronunciationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PronunciationScreenViewmodel>(
      init: PronunciationScreenViewmodel(),
      builder: (controller) {
        _body() {
          return Center(
            child: Text('Hi'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
