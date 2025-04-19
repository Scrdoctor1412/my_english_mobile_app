import 'package:englens/src/ui/screens/study/flashcards/flashcards_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashcardsScreen extends StatelessWidget {
  static const routeName = '/flashcardsScreen';

  const FlashcardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlashcardsScreenViewmodel>(
      init: FlashcardsScreenViewmodel(),
      builder: (controller) {
        _body() {
          return Center(
            child: Text('Hi flashcard'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
