import 'package:englens/src/ui/screens/study/random_flashcards/random_flashcards_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RandomFlashcardsScreen extends StatelessWidget {
  static const routeName = '/randomFlashcardsScreen';
  const RandomFlashcardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RandomFlashcardsScreenViewModel>(
      init: RandomFlashcardsScreenViewModel(),
      builder: (controller) {
        _appBar() {
          return AppBar(
            title: Text('Flashcards'),
          );
        }

        Widget _body() {
          return Center(
            child: Text('Hello worlds'),
          );
        }

        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }
}
