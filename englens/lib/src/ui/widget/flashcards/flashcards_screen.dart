import 'package:dartz/dartz.dart';
import 'package:englens/src/core/theme/theme_primary.dart';
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
            actions: [
              IconButton(
                onPressed: () {
                  controller.toggleVolume();
                },
                icon: controller.isVolumeOn
                    ? Icon(Icons.volume_up_rounded)
                    : Icon(Icons.volume_off),
              ),
            ],
          );
        }

        _body() {
          return Column(
            children: [
              LinearProgressIndicator(
                value: controller.progressValue,
                // trackGap: 2,
              ),
              Expanded(
                child: PageView.builder(
                  // reverse: true,
                  controller: controller.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: FlashcardItem(
                        definition:
                            controller.tempWordList[index].senses[0].definition,
                        imgUrl: controller.tempWordList[index].img,
                        isVolumeOn: controller.isVolumeOn,
                        onTapCorrect: controller.onTapCorrect,
                        onTapIncorrect: controller.onTapIncorrect,
                        pos: controller.tempWordList[index].pos,
                        word: controller.tempWordList[index].word,
                        audioUrl: controller.tempWordList[index].phonetic,
                      ),
                    );
                  },
                  itemCount: controller.tempWordList.length,
                ),
              ),
            ],
          );
        }

        return Scaffold(appBar: _appBar(), body: _body());
      },
    );
  }
}
