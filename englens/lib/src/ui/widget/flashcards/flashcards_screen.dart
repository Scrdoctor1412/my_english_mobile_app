import 'package:dartz/dartz.dart';
import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/flashcards/flashcards_screen_viewmodel.dart';
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

        Widget flashcards(int index) {
          __flashcardFront() {
            return Container(
              height: screenHeight * 0.7,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: ThemePrimary.successGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    controller.wordList[index].word,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: ThemePrimary.primaryBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Text(
                      controller.wordList[index].pos,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 65,
                    decoration: BoxDecoration(
                      color: ThemePrimary.successGreen,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Tap to see the definition',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          __flashcardBack() {
            return Container(
              height: screenHeight * 0.7,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.wordList[index].img == null
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child:
                              Image.network(controller.wordList[index].img!)),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      controller.wordList[index].senses[0].definition,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: ThemePrimary.successGreen,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(50),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(-2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 20,
                    ),
                    child: Icon(
                      Icons.keyboard_return,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                      // color: ThemePrimary.successGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.onTapIncorrect();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Divider(
                                          color: Colors.red,
                                        )),
                                        Container(
                                          width: 39,
                                          height: 39,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          // padding: const EdgeInsets.all(12),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Expanded(
                                            child: Divider(
                                          color: Colors.red,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Incorrect',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.onTapCorrect();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Divider(
                                          color: ThemePrimary.successGreen,
                                        )),
                                        Container(
                                          width: 39,
                                          height: 39,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ThemePrimary.successGreen,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          // padding: const EdgeInsets.all(12),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.check,
                                            color: ThemePrimary.successGreen,
                                          ),
                                        ),
                                        Expanded(
                                            child: Divider(
                                          color: ThemePrimary.successGreen,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Correct',
                                  style: TextStyle(
                                    color: ThemePrimary.successGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            child: Center(
              child: GestureDetector(
                onTap: controller.toggleCard,
                child: AnimatedBuilder(
                  animation: controller.animation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.rotationY(
                        controller.animation.value * 3.14139,
                      ),
                      alignment: Alignment.center,
                      child: controller.animation.value < 0.5
                          ? __flashcardFront()
                          : Transform.scale(
                              scaleX: -1,
                              scaleY: 1,
                              child: __flashcardBack(),
                            ),
                    );
                  },
                ),
              ),
            ),
          );
        }

        _body() {
          return Column(
            children: [
              LinearProgressIndicator(
                value: 0,
              ),
              Expanded(
                child: PageView.builder(
                  // reverse: true,
                  // controller: controller.pageController,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Container(child: flashcards(index)),
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
