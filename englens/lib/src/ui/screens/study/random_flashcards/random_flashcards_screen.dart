import 'package:englens/src/core/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/random_flashcards/random_flashcards_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RandomFlashcardsScreen extends GetView<RandomFlashcardsScreenViewModel> {
  static const routeName = '/randomFlashcardsScreen';
  const RandomFlashcardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    var screenWdith = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    _appBar() {
      return AppBar(
        title: Text('Flashcards'),
        backgroundColor: ThemePrimary.primaryOrange,
      );
    }

    _autoRandomFlascardBlock() {
      return InkWell(
        onTap: () {
          controller.onTapCardDeckPreparation();
        },
        child: Container(
          width: screenWdith,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Random flashcards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text('Automatically add 10 random words for you to review'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/study/flashcard.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    _randomFromWordListBlock() {
      return InkWell(
        onTap: () {
          // controller.onTapCardDeckPreparation();
          controller.onTapToWordList();
        },
        child: Container(
          width: screenWdith,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Random from word list',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text('Choose words from your word list to review'),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/study/flashcard.png'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget _body() {
      return Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_autoRandomFlascardBlock(), _randomFromWordListBlock()],
        ),
      );
    }

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
