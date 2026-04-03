import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/random_flashcards/card_deck_preparation/card_deck_preparation_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/english_card.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDeckPreparationScreen
    extends GetView<CardDeckPreparationScreenViewmodel> {
  static const routeName = "/cardDeckPreparationScreen";
  const CardDeckPreparationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar() {
      return AppBar(
        // primary: false,
        backgroundColor: ThemePrimary.primaryOrange,
        title: Text('Random Flashcards'),
      );
    }

    _wordListTab() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: 230,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          WordDetailsScreen.routeName,
                          arguments: WordDetailsScreenViewmodelArgs(
                            lessonTitle: '',
                            isFromLessonDetailsScreen: false,
                            onlyWord: [controller.words[index]],
                          ),
                        );
                      },
                      child: EnglishCard(word: controller.words[index]),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(),
              itemCount: controller.words.length,
            ),
          ),
        ],
      );
    }

    _body() {
      return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Stack(
          children: [
            Column(children: [Expanded(child: _wordListTab())]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 42),
                child: ElevatedButton(
                  onPressed: () {
                    controller.onTapLearnNow();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemePrimary.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
                    elevation: 4,
                  ),
                  child: Text(
                    'Learn now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
