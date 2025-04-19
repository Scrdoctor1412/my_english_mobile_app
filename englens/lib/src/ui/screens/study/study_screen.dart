import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/screens/study/expressions/expressions_screen.dart';
import 'package:englens/src/ui/screens/study/flashcards/flashcards_screen.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_screen.dart';
import 'package:englens/src/ui/screens/study/pronunciation/pronunciation_screen.dart';
import 'package:englens/src/ui/screens/study/study_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/study/vocab/vocab_screen.dart';
import 'package:englens/src/ui/screens/study/widget/big_content_block_widget.dart';
import 'package:englens/src/ui/screens/study/widget/small_content_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyScreen extends StatelessWidget {
  static const routeName = '/studyScreen';
  const StudyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyScreenViewmodel>(
      init: StudyScreenViewmodel(),
      builder: (controller) {
        controller.context = context;
        var screenWdith = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        _customBackground() {
          return Container(
            width: screenWdith,
            height: screenHeight * 0.4,
            decoration: BoxDecoration(
              color: ThemePrimary.primaryOrange,
              // color: Color(0xFFE1BEE7), //nice lavender
              // color: Color(0xFFB3E5FC), //pastel blue
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xFFB3E5FC), //pastel blue
              //     Color(0xFFE1BEE7), //nice lavender
              //   ],
              // ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          );
        }

        _contentGrid() {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // spacing: 5,
                  children: [
                    Column(
                      spacing: 12,
                      children: [
                        BigContentBlockWidget(
                          title: 'Vocabulary by Topics',
                          subTitle: 'Start learning new words through topics',
                          image: Image.asset('assets/images/study/vocab.png'),
                          color: Color(0xffe7f5f5),
                          toScreen: () {
                            Get.toNamed(VocabScreen.routeName);
                          },
                        ),
                        SmallContentBlockWidget(
                          title: 'Expressions',
                          subTitle: 'Idioms and phrases',
                          image: Image.asset(
                              'assets/images/study/expressions.png'),
                          toScreen: () =>
                              Get.toNamed(ExpressionsScreen.routeName),
                        ),
                        SizedBox(
                          height: 124,
                          child: Image.asset(
                              'assets/images/study/study_apple_1.png'),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SmallContentBlockWidget(
                          title: 'Grammar',
                          subTitle: 'Learn grammar rules',
                          image: Image.asset(
                            'assets/images/study/book_grammar.png',
                            fit: BoxFit.contain,
                          ),
                          toScreen: () => Get.toNamed(GrammarScreen.routeName),
                        ),
                        SmallContentBlockWidget(
                          title: 'Pronunciation',
                          subTitle: 'Practice pronunciation',
                          color: Color(0xfffbf1eb),
                          image: Image.asset(
                              'assets/images/study/pronunciation.png'),
                          toScreen: () =>
                              Get.toNamed(PronunciationScreen.routeName),
                        ),
                        SmallContentBlockWidget(
                          title: 'Flashcards',
                          subTitle: 'Learn with random flashcards',
                          image: Image.asset(
                            'assets/images/study/flashcard.png',
                          ),
                          toScreen: () =>
                              Get.toNamed(FlashcardsScreen.routeName),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        _bodyBlock() {
          return Container(
            width: screenWdith,
            // height: 200,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  spreadRadius: 1.5,
                  blurRadius: 2,
                ),
              ],
            ),
            child: _contentGrid(),
          );
        }

        _body() {
          return Stack(
            children: [
              SizedBox(
                width: screenWdith,
                height: screenHeight,
              ),
              Positioned(
                top: 0,
                child: _customBackground(),
              ),
              Positioned(
                top: 60,
                left: 16,
                child: Container(
                  width: screenWdith,
                  child: Row(
                    children: [
                      Text(
                        'Let\'s study',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.folder_copy,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 120,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
                  child: _bodyBlock(),
                ),
              ),
            ],
          );
        }

        return Scaffold(
          body: _body(),
        );
      },
    );
  }
}
