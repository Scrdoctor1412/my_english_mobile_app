import 'package:englens/src/ui/screens/study/random_flashcards/card_deck_preparation/card_deck_preparation_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDeckPreparationScreen extends StatelessWidget {
  static const routeName = "/cardDeckPreparationScreen";
  const CardDeckPreparationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardDeckPreparationScreenViewmodel>(
      init: CardDeckPreparationScreenViewmodel(),
      builder: (controller) {
        _body() {
          return Center(
            child: Text('Hello world'),
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
