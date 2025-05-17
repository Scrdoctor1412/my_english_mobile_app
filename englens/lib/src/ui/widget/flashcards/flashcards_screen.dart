import 'package:dartz/dartz.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/flashcards/widget/flashcard_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashcardsScreen extends StatelessWidget {
  static const routeName = '/flashcardsScreen';
  const FlashcardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlashcardsScreenViewmodel>(
      init: FlashcardsScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;
        _appBar() {
          return AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              controller.title,
              style: TextStyle(color: Colors.black),
            ),
            foregroundColor: Colors.black,
          );
        }

        _body() {
          return Column(
            children: [
              LinearProgressIndicator(
                value: controller.progressValue,
              ),
              Expanded(
                child: PageView.builder(
                  // reverse: true,
                  controller: controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: FlashcardItem(
                        definition:
                            controller.wordList[index].senses[0].definition,
                        imgUrl: controller.wordList[index].img,
                        isFront: controller.isFront,
                        onTapCorrect: controller.onTapCorrect,
                        onTapIncorrect: controller.onTapIncorrect,
                        pos: controller.wordList[index].pos,
                        word: controller.wordList[index].word,
                      ),
                    );
                  },
                  itemCount: controller.wordList.length,
                ),
              )
            ],
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
